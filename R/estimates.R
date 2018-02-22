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
estimates.mcarray <- function(object, fun = stats::median, as_df = FALSE, ...) {
  if(!as_df)
    return(estimates(as.mcmcarray(object), fun = fun, as_df = FALSE))
  estimates(coda::as.mcmc.list(object), fun = fun, as_df = TRUE)
}

#' @export
estimates.mcmc <- function(object, fun = stats::median, as_df = FALSE, ...) {
  if(!as_df)
    return(estimates(as.mcmcr(object), fun = fun, as_df = FALSE))

  terms <- terms(object)
  object <- t(object)
  object <- .estimates(object, fun = fun)
  tibble::tibble(term = terms, estimate = object)
}

#' @export
estimates.mcmc.list <- function(object, fun = stats::median, as_df = FALSE, ...) {
  if(!as_df)
    return(estimates(as.mcmcr(object), fun = fun, as_df = FALSE))

  object <- collapse_chains(object)
  estimates(object, fun = fun, as_df = TRUE)
}

#' @export
estimates.mcmcarray <- function(object, fun = stats::median, as_df = FALSE, ...) {
  check_function(fun)
  check_flag(as_df)

  if(as_df)
    return(estimates(coda::as.mcmc.list(object), fun = fun, as_df = TRUE))

  object <- collapse_chains(object)
  apply(object, 3:ndims(object), FUN = .estimates, fun = fun)
}

#' @export
estimates.mcmcr <- function(object, fun = stats::median, as_df = FALSE, ...) {
  if(as_df)
    return(estimates(coda::as.mcmc.list(object), fun = fun, as_df = TRUE))
  lapply(object, estimates, fun = fun, as_df = FALSE, ...)
}
