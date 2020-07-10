#' Combine two MCMC objects by iterations
#'
#' Combines two MCMC objects (with the same parameters and chains) by iterations.
#'
#' @param x an MCMC object
#' @param x2 a second MCMC object
#' @param ... unused
#' @export
#' @examples
#' bind_iterations(mcmcr_example, mcmcr_example)
bind_iterations <- function(x, x2, ...) {
  UseMethod("bind_iterations")
}

#' @export
bind_iterations.mcarray <- function(x, x2, ...) {
  chk_s3_class(x2, "mcarray")

  if (!identical(pdims(x), pdims(x2))) {
    abort_chk("`x` and `x2` must have the same parameter dimensions")
  }

  if (!identical(nchains(x), nchains(x2))) {
    abort_chk("`x` and `x2` must have the same number of chains")
  }

  x <- abind(x, x2, along = ndims(x) - 1)
  set_class(x, "mcarray")
}

#' @export
bind_iterations.mcmc <- function(x, x2, ...) {
  chk_s3_class(x2, "mcmc")

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(pars(x), pars(x2))) {
    abort_chk("`x` and `x2` must have the same parameters")
  }

  if (!identical(pdims(x), pdims(x2))) {
    abort_chk("`x` and `x2` must have the same parameter dimensions")
  }

  if (!identical(nchains(x), nchains(x2))) {
    abort_chk("`x` and `x2` must have the same number of chains")
  }

  x <- abind(x, x2, along = 1)
  as.mcmc(x)
}

#' @export
bind_iterations.mcmc.list <- function(x, x2, ...) {
  chkor(chk_s3_class(x2, "mcmc.list"), chk_s3_class(x2, "mcmc"))

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(pars(x), pars(x2))) {
    abort_chk("`x` and `x2` must have the same parameters")
  }

  if (!identical(pdims(x), pdims(x2))) {
    abort_chk("`x` and `x2` must have the same parameter dimensions")
  }

  if (!identical(nchains(x), nchains(x2))) {
    abort_chk("`x` and `x2` must have the same number of chains")
  }

  x <- mapply(x, x2, FUN = bind_iterations, SIMPLIFY = FALSE)
  set_class(x, "mcmc.list")
}

#' @export
bind_iterations.mcmcarray <- function(x, x2, ...) {
  chk_s3_class(x2, "mcmcarray")

  if (!identical(pdims(x), pdims(x2))) {
    abort_chk("`x` and `x2` must have the same parameter dimensions")
  }

  if (!identical(nchains(x), nchains(x2))) {
    abort_chk("`x` and `x2` must have the same number of chains")
  }

  x <- abind(x, x2, along = 2, dimnames = FALSE)
  set_class(x, "mcmcarray")
}

#' @export
bind_iterations.mcmcr <- function(x, x2, ...) {
  chk_s3_class(x2, "mcmcr")

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(pars(x), pars(x2))) {
    abort_chk("`x` and `x2` must have the same parameters")
  }

  if (!identical(pdims(x), pdims(x2))) {
    abort_chk("`x` and `x2` must have the same parameter dimensions")
  }

  if (!identical(nchains(x), nchains(x2))) {
    abort_chk("`x` and `x2` must have the same number of chains")
  }

  x <- mapply(x, x2, FUN = bind_iterations, SIMPLIFY = FALSE)
  set_class(x, "mcmcr")
}
