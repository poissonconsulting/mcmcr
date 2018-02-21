#' Test whether an object is a term.
#' @param x The object to test.
#' @param ... Unused.
#' @export
#' @examples
#' is.term(terms(mcmcr_example))
is.term <- function(x, ...) inherits(x, "term")

is.mcarray <- function(x) inherits(x, "mcarray")

#' Is an mcmcrarray object
#'
#' Tests whether x is an object of class 'mcmcarray'
#'
#' @param x The object to test.
#'
#' @return A flag indicating whether the test was positive.
#' @export
#' @examples
#' is.mcmcarray(mcmcr_example$beta)
is.mcmcarray <- function(x) inherits(x, "mcmcarray")

#' Is an mcmcr object
#'
#' Tests whether x is an object of class 'mcmcr'
#'
#' @param x The object to test.
#'
#' @return A flag indicating whether the test was positive.
#' @export
#' @examples
#' is.mcmcr(mcmcr_example)
is.mcmcr <- function(x) inherits(x, "mcmcr")

#' Is an mcmcrs object
#'
#' Tests whether x is an object of class 'mcmcrs'
#'
#' @param x The object to test.
#'
#' @return A flag indicating whether the test was positive.
#' @export
#' @examples
#' is.mcmcr(mcmcrs(mcmcr_example))
is.mcmcrs <- function(x)  inherits(x, "mcmcrs")
