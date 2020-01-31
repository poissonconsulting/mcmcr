#' @export
universals::estimates

#' @inherit universals::estimates
#' @inheritParams params
#' @return A named list or data frame.
#' @export
estimates.mcarray <- function(x, fun = median, as_df = FALSE, ...) {
  if(!as_df)
    return(estimates(as.mcmcarray(x), fun = fun, as_df = FALSE))
  estimates(as.mcmc.list(x), fun = fun, as_df = TRUE)
}

#' @inherit universals::estimates
#' @inheritParams params
#' @return A named list or data frame.
#' @export
estimates.mcmc <- function(x, fun = median, as_df = FALSE, ...) {
  if(!as_df)
    return(estimates(as.mcmcr(x), fun = fun, as_df = FALSE))

  term <- as.term(x)
  x <- t(x)
  x <- .estimates(x, fun = fun)
  tibble(term = term, estimate = x)
}

#' @inherit universals::estimates
#' @inheritParams params
#' @return A named list or data frame.
#' @export
estimates.mcmc.list <- function(x, fun = median, as_df = FALSE, ...) {
  if(!as_df)
    return(estimates(as.mcmcr(x), fun = fun, as_df = FALSE))

  x <- as.mcmc(collapse_chains(x))
  estimates(x, fun = fun, as_df = TRUE)
}

#' @inherit universals::estimates
#' @inheritParams params
#' @param ... Unused.
#' @return A named list or data frame.
#' @export
estimates.mcmcarray <- function(x, fun = median, as_df = FALSE, ...) {
  chk_function(fun)
  chk_flag(as_df)

  if(as_df)
    return(estimates(as.mcmc.list(x), fun = fun, as_df = TRUE))

  x <- collapse_chains(x)
  apply(x, 3:ndims(x), FUN = .estimates, fun = fun)
}

#' @inherit universals::estimates
#' @inheritParams params
#' @return A named list or data frame.
#' @export
#' @examples
#' estimates(mcmcr_example)
estimates.mcmcr <- function(x, fun = median, as_df = FALSE, ...) {
  if(as_df)
    return(estimates(as.mcmc.list(x), fun = fun, as_df = TRUE))
  lapply(x, estimates, fun = fun, as_df = FALSE, ...)
}
