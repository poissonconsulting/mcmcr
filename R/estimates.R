#' Get Estimates
#'
#' Gets the estimates for an object as a named list.
#'
#' @param object The object.
#' @param ...  Not used.
#' @export
#' @examples
#' estimates(mcmcr_example)
estimates <- function(object, ...) {
  UseMethod("estimates")
}

#' @export
estimates.mcarray <- function(object, fun = stats::median, as_list = TRUE, ...) {
  if(as_list)
    return(estimates(as.mcmcarray(object), fun = fun, as_list = TRUE))
  estimates(coda::as.mcmc.list(object), fun = fun, as_list = FALSE)
}

#' @export
estimates.mcmc <- function(object, fun = stats::median, as_list = TRUE, ...) {
  if(as_list)
    return(estimates(as.mcmcr(object), fun = fun, as_list = TRUE))

  terms <- terms(object)
  object <- t(object)
  object <- apply(object, MARGIN = 1, FUN = fun, ...)
  if(!is.numeric(object)) error("function fun must return a scalar")
  tibble::tibble(term = terms, estimate = object)
}

#' @export
estimates.mcmc.list <- function(object, fun = stats::median, as_list = TRUE, ...) {
  if(as_list)
    return(estimates(as.mcmcr(object), fun = fun, as_list = TRUE))

  object <- collapse_chains(object)
  estimates(object, fun = fun, as_list = FALSE)
}

#' @export
estimates.mcmcarray <- function(object, fun = stats::median, as_list = TRUE, ...) {
  check_function(fun)
  check_flag(as_list)

  if(!as_list)
    return(estimates(coda::as.mcmc.list(object), fun = fun, as_list = FALSE))

  ndims <- ndims(object)
  object <- apply(object, 3:ndims, FUN = fun, ...)
  if(!identical(ndims(object), ndims - 2L))
    error("function fun must return a scalar")
  object
}

#' @export
estimates.mcmcr <- function(object, fun = stats::median, as_list = TRUE, ...) {
  if(!as_list)
    return(estimates(coda::as.mcmc.list(object), fun = fun, as_list = FALSE))
  lapply(object, estimates, fun = fun, as_list = TRUE, ...)
}
