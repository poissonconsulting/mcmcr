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
estimates.mcmcarray <- function(object, fun = stats::median, ...) {
    apply(object, 3:ndims(object), FUN = fun, ...)
}

#' @export
estimates.mcmcr <- function(object, fun = stats::median, ...) {
  llply(object, estimates, fun, ...)
}
