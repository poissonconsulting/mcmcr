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

#' @export
bind_parameters.mcmc <- function(x, x2, ...) {

  if (!identical(niters(x), niters(x2)))
    error("x and x2 must have the same number of iterations")

  x <- abind::abind(x, x2, along = 2)

  coda::as.mcmc(x)
}

#' @export
bind_parameters.mcmc.list <- function(x, x2, ...) {

  if (!coda::is.mcmc.list(x)) error("x2 must be an mcmc.list")

  if (!identical(nchains(x), nchains(x2)))
    error("x and x2 must have the same number of chains")

  x <- purrr::map2(x, x2, bind_parameters)
  class(x) <- "mcmc.list"
  x
}

#' Combines objects by parameters
#'
#' @param x an mcmc object.
#' @param x2 a second mcmc object
#' @param ... Unused.
#' @export
bind_parameters.mcmcr <- function(x, x2, ...) {

  if (!identical(nchains(x), nchains(x2)))
    error("x and x2 must have the same number of chains")

  if (!identical(niters(x), niters(x2)))
    error("x and x2 must have the same number of iterations")

  if (length(intersect(parameters(x), parameters(x2))))
    error("x and x2 must not have the same parameters")

  x <- c(x, x2)
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
    parameters(x[[i]]) <- paste0(parameters(x[[i]]), i)

  x <- Reduce(bind_parameters, x)
  x
}

