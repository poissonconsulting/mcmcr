#' Get Estimates
#'
#' Gets the estimates for an object as a named list.
#'
#' @param object The object.
#' @param ...  Not used.
#' @return The estimates as a named list.
#' @export
estimates <- function(object, ...) {
  UseMethod("estimates")
}

#' @export
estimates.mcmcarray <- function(object, ...) {
  
  ndims <- ndims(object)
  apply(object, 3:ndims, stats::median, ...)
}

#' @export
estimates.mcmcr <- function(object, ...) {
  
  lapply(object, estimates)
}
