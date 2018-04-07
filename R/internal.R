dims_terms <- function(x) {
  .Deprecated("tdims")
  tdims(x)
}

greater_than_term <- function(e1, e2) {
  e1 <- as.term(e1)
  e2 <- as.term(e2)
  e1_parm <- parameters(e1)
  e2_parm <- parameters(e2)
  if (e1_parm != e2_parm) return(e1_parm > e2_parm)

  e1 <- tdims(e1)[[1]]
  e2 <- tdims(e2)[[1]]

  if (length(e1) != length(e2)) return(length(e1) > length(e2))

  equal <- e1 == e2

  if (all(equal)) return(FALSE)

  which <- which(!equal)
  which <- which[length(which)]

  e1[which] > e2[which]
}

error <- function(...) stop(..., call. = FALSE)

set_class <- function(x, class) {
  class(x) <- class
  x
}

#' @export
.esr <- function(x, ...) {
  stopifnot(is.matrix(x))
  niters <- niters(x)
  x <- apply(x, 1L, .esr_numeric)
  x <- unlist(x)
  round(mean(x), 3)
}

.esr_numeric <- function(x) {
  stopifnot(is.numeric(x))
  x <- stats::acf(x, lag.max = length(x) - 1, plot = FALSE)$acf[,,1]

  if (is.nan(x[1])) return(1) # all values identical

  x <- c(x, -1) # adds stopper
  match <- match(TRUE, x < 0)
  x <- sum(x[1:(match-1)]) - 1 # drops lag-0
  1 / (1 + 2 * x)
}

#' @export
.estimates <- function(object, fun = stats::median) {
  stopifnot(is.matrix(object))
  object <- apply(object, 1L, fun)
  if(!is.numeric(object)) error("function fun must return a scalar")
  object
}

#' @export
.rhat <- function(x) {
  stopifnot(is.matrix(x))

  mean_chain <- apply(x, 1L, mean)
  var_chain <- apply(x, 1L, stats::var)

  niters <- niters(x)

  var_between <- niters * stats::var(mean_chain)
  var_within <- mean(var_chain)
  rhat <- sqrt((var_between/var_within + niters - 1) / niters)

  if (is.nan(rhat)) rhat <- 1
  round(rhat, 3)
}

.thin <- function(x, nthin = 1L, ...) {
  check_vector(nthin, c(1L, niters(x)), length = 1)
  iterations <- seq(1L, niters(x), by = nthin)
  subset(x, iterations = iterations)
}
