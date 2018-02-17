#' Number of Parameters
#'
#' Gets the number of parameters for an object.
#'
#' @param x The object.
#' @param ... Not used.
#' @return A count of the number of terms.
#' @export
#' @examples
#'
npars <- function(x, ...) UseMethod("npars")

#' @export
npars.default <- function(x, ...) length(parameters(x))

#' @export
npars.mcarray <- function(x, ...) 1L

#' @export
npars.mcmcarray <- function(x, ...) 1L

#' @export
npars.mcmcr <- function(x, ...) length(x)

#' @export
npars.mcmcrs <- function(x, ...) npars(x[[1]])
