#' Test whether an object is a term.
#' @param x The object to test.
#' @param ... Unused.
#' @export
is.term <- function(x, ...) {
  inherits(x, "term")
}

#' Is an mcmcr object
#'
#' Tests whether x is an object of class 'mcmcr'
#'
#' @param x The object to test.
#'
#' @return A flag indicating whether the test was positive.
#' @export
is.mcmcr <- function(x) {
  inherits(x, "mcmcr")
}

#' Is an mcmcrarray object
#'
#' Tests whether x is an object of class 'mcmcarray'
#'
#' @param x The object to test.
#'
#' @return A flag indicating whether the test was positive.
#' @export
is.mcmcarray <- function(x) {
  inherits(x, "mcmcarray")
}

#' Is an mcmcrs object
#'
#' Tests whether x is an object of class 'mcmcrs'
#'
#' @param x The object to test.
#'
#' @return A flag indicating whether the test was positive.
#' @export
is.mcmcrs <- function(x) {
  inherits(x, "mcmcrs")
}
