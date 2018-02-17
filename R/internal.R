multiply_by <- function(x, x2) x * x2
equals <- function(x, x2) x == x2
error <- function(...) stop(..., call. = FALSE)

as_matrix_mcmcarray <- function(x) {
  x <- reshape2::melt(x)

  values <- x[c("Var1", "value")]
  x$Var1 <- NULL
  x$value <- NULL
  x <- tibble::tibble(
    term = apply(as.matrix(x), 1, function(x) paste(x, collapse = ","))
  )
  x$term <- paste0("[", x$term, "]")
  x <- cbind(x, values)
  x <- reshape2::dcast(x, Var1 ~ term)
  x$Var1 <- NULL
  as.matrix(x)
}

add_colname_matrix <- function(x, name) {
  if (length(colnames(x)) == 1) {
    colnames(x) <- name
  } else {
    colnames(x) <- paste0(name, colnames(x))
  }
  x
}

as_mcmc_mcmcarray1 <- function(x) {
  x <- lapply(as_matrix_mcmcarray1)
  x <- lapply(x, add_colname_matrix, name)
  x <- lapply(x, coda::as.mcmc)
}

dims_terms <- function(x) {
  x <- sub("^(\\w+)(.*)", "\\2", x)
  x <- sub("^(\\[)(.*)(\\])$", "\\2", x)
  x <- strsplit(x, "\\s*[,]\\s*")
  x <- purrr::map_if(x, function(x) identical(x, character(0)), function(x) "")
  x <- lapply(x, function(x) gsub("\\s+", "", x))
  x <- lapply(x, as.integer)
  x <- purrr::map_if(x, function(x) identical(x, NA_integer_), function(x) 1L)
  x
}

greater_than_term <- function(e1, e2) {
  e1 <- as.term(e1)
  e2 <- as.term(e2)
  e1_parm <- parameter(e1)
  e2_parm <- parameter(e2)
  if (e1_parm != e2_parm) return(e1_parm > e2_parm)

  e1 <- dims_terms(e1)[[1]]
  e2 <- dims_terms(e2)[[1]]

  if (length(e1) != length(e2)) return(length(e1) > length(e2))

  equal <- e1 == e2

  if (all(equal)) return(FALSE)

  which <- which(!equal)
  which <- which[length(which)]

  e1[which] > e2[which]
}

#' @export
as_mcmcarray_mcmc1 <- function(x, ...) {
  stopifnot(nchains(x) == 1L)
  stopifnot(npars(x) == 1L)

  dims <- parameter_dims(x)[[1]]
  x <- x[,order(terms(x)), drop = FALSE]
  x <- array(data = as.vector(x), dim = c(1,niters(x),dims))
  class(x) <- "mcmcarray"
  x
}
