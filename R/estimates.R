#' Estimates
#'
#' Get the estimates for an MCMC object.
#'
#' @param object An MCMC object.
#' @param fun The function to use.
#' @param as_df A flag indicating whether to return the estimates as a data frame versus a named list.
#' @param ... Unused.
#' @return A named list or data frame.
#' @export
#' @examples
#' estimates(mcmcr_example)
#' estimates(mcmcr_example, as_df = TRUE)
estimates <- function(object, ...) {
  UseMethod("estimates")
}

#' @describeIn estimates Estimates mcarray
#' @export
estimates.mcarray <- function(object, fun = stats::median, as_df = FALSE, ...) {
  if(!as_df)
    return(estimates(as.mcmcarray(object), fun = fun, as_df = FALSE))
  estimates(as.mcmc.list(object), fun = fun, as_df = TRUE)
}

#' @export
estimates.mcmc <- function(object, fun = stats::median, as_df = FALSE, ...) {
  if(!as_df)
    return(estimates(as.mcmcr(object), fun = fun, as_df = FALSE))

  term <- as.term(object)
  object <- t(object)
  object <- .estimates(object, fun = fun)
  tibble(term = term, estimate = object)
}

#' @export
estimates.mcmc.list <- function(object, fun = stats::median, as_df = FALSE, ...) {
  if(!as_df)
    return(estimates(as.mcmcr(object), fun = fun, as_df = FALSE))

  object <- as.mcmc(collapse_chains(object))
  estimates(object, fun = fun, as_df = TRUE)
}

#' @export
estimates.mcmcarray <- function(object, fun = stats::median, as_df = FALSE, ...) {
  check_function(fun)
  chk_flag(as_df)

  if(as_df)
    return(estimates(as.mcmc.list(object), fun = fun, as_df = TRUE))

  object <- collapse_chains(object)
  apply(object, 3:ndims(object), FUN = .estimates, fun = fun)
}

#' @export
estimates.mcmcr <- function(object, fun = stats::median, as_df = FALSE, ...) {
  if(as_df)
    return(estimates(as.mcmc.list(object), fun = fun, as_df = TRUE))
  lapply(object, estimates, fun = fun, as_df = FALSE, ...)
}
