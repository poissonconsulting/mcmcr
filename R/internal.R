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
  e1_parm <- parameters(e1)
  e2_parm <- parameters(e2)
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
