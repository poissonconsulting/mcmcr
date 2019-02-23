#' Number of Parameter Dimensions
#'
#' Gets the number parameter dimensions of an object.
#'
#' @param x The object
#' @param ... Unused.
#' @export
#' @examples
#' pdims(mcmcr_example)
npdims <- function(x, ...) UseMethod("npdims")

#' @describeIn pdims Parameter dimensions for a term vector
#' @export
npdims.default <- function(x, ...) {
  check_unused(...)
  length(pdims(x))
}

#' @describeIn pdims Parameter dimensions for an mcmcr object
#' @export
npdims.mcmc.list <- function(x, ...) {
  check_unused(...)
  lapply(pdims(x), length)
}

#' @describeIn pdims Parameter dimensions for an mcmcr object
#' @export
npdims.mcmcr <- function(x, ...) {
  check_unused(...)
  vapply(x, npdims, 1L)
}
