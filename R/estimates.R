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
  check_unused(...)
  summary(object)
}

#' @export
estimates.mcmcr <- function(object, ...) {
  check_unused(...)
  lapply(object, estimates)
}
