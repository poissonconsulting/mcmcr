#' Combine two MCMC object by parameters
#'
#' Combines two MCMC objects (with the same chains and iterations) by their parameters.
#'
#' @inheritParams params
#' @param x an MCMC object
#' @seealso [universals::bind_chains()]
#' @family bind
#' @export
#' @examples
#' bind_parameters(
#'   subset(mcmcr_example, pars = "sigma"),
#'   subset(mcmcr_example, pars = "beta")
#' )
bind_parameters <- function(x, x2, ...) {
  UseMethod("bind_parameters")
}

#' @export
bind_parameters.mcmc <- function(x, x2, ...) {
  chk_s3_class(x2, "mcmc")

  if (length(intersect(pars(x), pars(x2)))) {
    abort_chk("`x` and `x2` must not have any of the same parameters")
  }

  if (!identical(niters(x), niters(x2))) {
    abort_chk("`x` and `x2` must have the same number of iterations")
  }

  x <- abind(x, x2, along = 2)
  x <- as.mcmc(x)
  sort(x)
}

#' @export
bind_parameters.mcmc.list <- function(x, x2, ...) {
  chk_s3_class(x2, "mcmc.list")

  if (length(intersect(pars(x), pars(x2)))) {
    abort_chk("`x` and `x2` must not have any of the same parameters")
  }

  if (!identical(nchains(x), nchains(x2))) {
    abort_chk("`x` and `x2` must have the same number of chains")
  }

  if (!identical(niters(x), niters(x2))) {
    abort_chk("`x` and `x2` must have the same number of iterations")
  }

  x <- mapply(x, x2, FUN = bind_parameters, SIMPLIFY = FALSE)
  set_class(x, "mcmc.list")
}

#' @export
bind_parameters.mcmcr <- function(x, x2, ...) {
  chk_s3_class(x2, "mcmcr")

  if (length(intersect(pars(x), pars(x2)))) {
    abort_chk("`x` and `x2` must not have any of the same parameters")
  }

  if (!identical(nchains(x), nchains(x2))) {
    abort_chk("`x` and `x2` must have the same number of chains")
  }

  if (!identical(niters(x), niters(x2))) {
    abort_chk("`x` and `x2` must have the same number of iterations")
  }

  x <- c(x, x2)
  x <- set_class(x, "mcmcr")
  sort(x)
}
