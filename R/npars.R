#' Number of Parameters
#'
#' Gets the number of parameters for an object.
#'
#' @param x The object.
#' @param ... Not used.
#' @return A count of the number of parameters.
#' @export
#' @examples
#' npars(mcmcr_example)
npars <- function(x, ...) UseMethod("npars")

#' @describeIn npars Number of parameters for an object
#' @export
npars.default <- function(x, ...) length(parameters(x))

#' @describeIn npars Number of parameters for an mcarray object
#' @export
npars.mcarray <- function(x, ...) 1L

#' @describeIn npars Number of parameters for an mcmcarray object
#' @export
npars.mcmcarray <- function(x, ...) 1L

#' @describeIn npars Number of parameters for an mcmcr object
#' @export
npars.mcmcr <- function(x, ...) length(x)

#' @describeIn npars Number of parameters for an mcmcrs object
#' @export
npars.mcmcrs <- function(x, ...) npars(x[[1]])
