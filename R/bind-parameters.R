#' Combines objects by parameters
#'
#' Combines an mcmc object(s) by parameters.
#'
#' They must have the same number of chains and iterations but different parameters.
#'
#' @param x an mcmc object.
#' @param ... Unused.
#' @export
#' @examples
#' bind_parameters(subset(mcmcr_example, parameters = "sigma"),
#'   subset(mcmcr_example, parameters = "beta"))
bind_parameters <- function(x, ...) {
  UseMethod("bind_parameters")
}

#' @export
bind_parameters.mcmc <- function(x, x2, ...) {
  if (!coda::is.mcmc(x2)) error("x2 must be an mcmc.list")

  if (length(intersect(parameters(x), parameters(x2))))
    error("x and x2 must not have any of the same parameters")

  if (!identical(niters(x), niters(x2)))
    error("x and x2 must have the same number of iterations")

  x <- abind::abind(x, x2, along = 2)
  x <- coda::as.mcmc(x)
  sort(x)
}

#' @export
bind_parameters.mcmc.list <- function(x, x2, ...) {
  if (!coda::is.mcmc.list(x2)) error("x2 must be an mcmc.list")

  if (length(intersect(parameters(x), parameters(x2))))
    error("x and x2 must not have any of the same parameters")

    if (!identical(nchains(x), nchains(x2)))
    error("x and x2 must have the same number of chains")

  if (!identical(niters(x), niters(x2)))
    error("x and x2 must have the same number of iterations")

  x <- mapply(x, x2, FUN = bind_parameters, SIMPLIFY = FALSE)
  set_class(x, "mcmc.list")
}

#' @export
bind_parameters.mcmcr <- function(x, x2, ...) {
  if (!is.mcmcr(x)) error("x2 must be an mcmcr")

  if (length(intersect(parameters(x), parameters(x2))))
    error("x and x2 must not have any of the same parameters")

    if (!identical(nchains(x), nchains(x2)))
    error("x and x2 must have the same number of chains")

  if (!identical(niters(x), niters(x2)))
    error("x and x2 must have the same number of iterations")

  x <- c(x, x2)
  x <- set_class(x, "mcmcr")
  sort(x)
}
