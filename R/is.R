#' Is mcarray object
#'
#' Tests whether an object is an mcarray.
#'
#' @param x The object to test.
#' @return A flag indicating whether the test was positive.
#' @family is
#' @export
#' @examples
#' is.mcarray(mcmcr_example)
is.mcarray <- function(x) inherits(x, "mcarray")

#' Is mcmcarray object
#'
#' Tests whether an object is an [mcmcarray-object()].
#'
#' @param x The object to test.
#' @return A flag indicating whether the test was positive.
#' @family is
#' @export
#' @examples
#' is.mcmcarray(mcmcr_example$beta)
is.mcmcarray <- function(x) inherits(x, "mcmcarray")

#' Is mcmcr object
#'
#' Tests whether an object is an [mcmcr-object()].
#'
#' @param x The object to test.
#' @return A flag indicating whether the test was positive.
#' @family is
#' @export
#' @examples
#' is.mcmcr(mcmcr_example)
is.mcmcr <- function(x) inherits(x, "mcmcr")

#' Is mcmcrs object
#'
#' Tests whether an object is an [mcmcrs-object()].
#'
#' @param x The object to test.
#' @return A flag indicating whether the test was positive.
#' @family is
#' @export
#' @examples
#' is.mcmcrs(mcmcrs(mcmcr_example))
is.mcmcrs <- function(x) inherits(x, "mcmcrs")
