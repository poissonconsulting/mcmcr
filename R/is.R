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

#' Is an mcmcr data object
#'
#' Tests whether x is an object of class 'mcmcr_data'
#'
#' @param x The object to test.
#'
#' @return A flag indicating whether the test was positive.
#' @export
is.mcmcr_data <- function(x) {
  inherits(x, "mcmcr_data")
}
