#' Combine two MCMC object by parameters
#'
#' Combines two MCMC objects (with the same chains and iterations) by their parameters.
#'
#' @param x an MCMC object
#' @param x2 a second MCMC object
#' @param ... unused
#' @export
#' @examples
#' bind_parameters(subset(mcmcr_example, parameters = "sigma"),
#'   subset(mcmcr_example, parameters = "beta"))
bind_parameters <- function(x, ...) {
  UseMethod("bind_parameters")
}

#' @describeIn bind_parameters Binds two mcmc objects by their parameters
#' @export
bind_parameters.mcmc <- function(x, x2, ...) {
  if (!is.mcmc(x2)) err("x2 must be an mcmc.list")

  if (length(intersect(parameters(x), parameters(x2))))
    err("x and x2 must not have any of the same parameters")

  if (!identical(niters(x), niters(x2)))
    err("x and x2 must have the same number of iterations")

  x <- abind::abind(x, x2, along = 2)
  x <- as.mcmc(x)
  sort(x)
}

#' @describeIn bind_parameters Binds two mcmc.list objects by their parameters
#' @export
bind_parameters.mcmc.list <- function(x, x2, ...) {
  if (!is.mcmc.list(x2)) err("x2 must be an mcmc.list")

  if (length(intersect(parameters(x), parameters(x2))))
    err("x and x2 must not have any of the same parameters")

    if (!identical(nchains(x), nchains(x2)))
    err("x and x2 must have the same number of chains")

  if (!identical(niters(x), niters(x2)))
    err("x and x2 must have the same number of iterations")

  x <- mapply(x, x2, FUN = bind_parameters, SIMPLIFY = FALSE)
  set_class(x, "mcmc.list")
}

#' @describeIn bind_parameters Binds two mcmcr objects by their parameters
#' @export
bind_parameters.mcmcr <- function(x, x2, ...) {
  if (!is.mcmcr(x)) err("x2 must be an mcmcr")

  if (length(intersect(parameters(x), parameters(x2))))
    err("x and x2 must not have any of the same parameters")

    if (!identical(nchains(x), nchains(x2)))
    err("x and x2 must have the same number of chains")

  if (!identical(niters(x), niters(x2)))
    err("x and x2 must have the same number of iterations")

  x <- c(x, x2)
  x <- set_class(x, "mcmcr")
  sort(x)
}
