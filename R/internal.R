error <- function(...) stop(..., call. = FALSE)

set_class <- function(x, class) {
  class(x) <- class
  x
}

derive_sample <- function(i, object, expr, values, monitor) {
  object <- subset(object, iterations = i)
  object <- estimates(object)
  object <- c(object, values)
  object <- within(object, eval(expr))
  object <- object[monitor]
  object <- lapply(object, function(x) { dim(x) <- c(1L, 1L, dims(x)); class(x) <- "mcmcarray"; x})

  class(object) <- "mcmcr"

  object
}

derive_chain <- function(i, object, expr, values, monitor) {
  object <- subset(object, chains = i)

  object <- lapply(1:niters(object), FUN = derive_sample, object = object,
                  expr = expr, values = values, monitor = monitor)
  object <- Reduce(bind_iterations, object)
  object
}

dims_terms <- function(x) {
  x <- sub("^(\\w+)(.*)", "\\2", x)
  x <- sub("^(\\[)(.*)(\\])$", "\\2", x)
  x <- strsplit(x, "\\s*[,]\\s*")
  x[vapply(x, function(x) identical(x, character(0)), TRUE)] <- ""
  x <- lapply(x, function(x) gsub("\\s+", "", x))
  x <- lapply(x, as.integer)
  x[is.na(x)] <- 1L
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
