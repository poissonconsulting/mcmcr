#' Combines objects by parameters
#'
#' Combines an mcmc object(s) by parameters.
#'
#' @param x an mcmc object.
#' @param ... Unused.
#' @export
bind_parameters <- function(x, ...) {
  UseMethod("bind_parameters")
}

#' Combines objects by parameters
#'
#' @param x an mcmc object.
#' @param x2 a second mcmc object
#' @param ... Unused.
#' @export
bind_parameters.mcmcr <- function(x, x2, ...) {

  if (!identical(coda::nchain(x), coda::nchain(x2)))
    error("x and x2 must have the same number of chains")

  if (!identical(coda::niter(x), coda::niter(x2)))
    error("x and x2 must have the same number of iterations")

  if (length(intersect(parameters(x), parameters(x2))))
    error("x and x2 must not have the same parameters")

  x %<>% c(x2)
  class(x) <- "mcmcr"
  x
}

#' Combines objects in mcmcrs by parameters.
#'
#' Ensures parameter names are distinct.
#'
#' @param x an mcmc object.
#' @param ... Unused.
#' @export
bind_parameters.mcmcrs <- function(x, ...) {
  if (!length(x)) return(x)

  for (i in seq_along(x))
    parameters(x[[i]]) %<>% paste0(i)

  x %<>% purrr::reduce(bind_parameters)
  x
}

