error <- function(...) stop(..., call. = FALSE)

set_class <- function(x, class) {
  class(x) <- class
  x
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

.thin <- function(x, nthin = 1L, ...) {
  check_vector(nthin, c(1L, niters(x)), length = 1)
  iterations <- seq(1L, niters(x), by = nthin)
  subset(x, iterations = iterations)
}
