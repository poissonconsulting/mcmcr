#' @export
universals::bind_chains

#' @inherit universals::bind_chains
#' @export
bind_chains.mcarray <- function(x, x2, ...) {
  chk_s3_class(x2, "mcarray")

  if (!identical(pdims(x), pdims(x2))) {
    abort_chk("`x` and `x2` must have the same parameter dimensions")
  }

  if (!identical(niters(x), niters(x2))) {
    abort_chk("`x` and `x2` must have the same number of iterations")
  }

  x <- abind(x, x2, along = ndims(x))
  set_class(x, "mcarray")
}

#' @inherit universals::bind_chains
#' @export
bind_chains.mcmc <- function(x, x2, ...) {
  chk_s3_class(x2, "mcmc")

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(pars(x), pars(x2))) {
    abort_chk("`x` and `x2` must have the same parameters")
  }

  if (!identical(pdims(x), pdims(x2))) {
    abort_chk("`x` and `x2` must have the same parameter dimensions")
  }

  if (!identical(niters(x), niters(x2))) {
    abort_chk("`x` and `x2` must have the same number of iterations")
  }

  as.mcmc.list(list(x, x2))
}

#' @inherit universals::bind_chains
#' @export
bind_chains.mcmc.list <- function(x, x2, ...) {
  if(!vld_s3_class(x, "mcmc") && !vld_s3_class(x, "mcmc.list")) {
    chkor_vld(vld_s3_class(x, "mcmc"), vld_s3_class(x, "mcmc.list"))
  }

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(pars(x), pars(x2))) {
    abort_chk("`x` and `x2` must have the same parameters")
  }

  if (!identical(pdims(x), pdims(x2))) {
    abort_chk("`x` and `x2` must have the same parameter dimensions")
  }

  if (!identical(niters(x), niters(x2))) {
    abort_chk("`x` and `x2` must have the same number of iterations")
  }

  x <- c(x, x2)
  set_class(x, "mcmc.list")
}

#' @inherit universals::bind_chains
#' @export
bind_chains.mcmcarray <- function(x, x2, ...) {
  chk_s3_class(x2, "mcmcarray")

  if (!identical(pdims(x), pdims(x2))) {
    abort_chk("`x` and `x2` must have the same parameter dimensions")
  }

  if (!identical(niters(x), niters(x2))) {
    abort_chk("`x` and `x2` must have the same number of iterations")
  }

  x <- abind(x, x2, along = 1, dimnames = FALSE)
  set_class(x, "mcmcarray")
}

#' @inherit universals::bind_chains
#' @export
bind_chains.mcmcr <- function(x, x2, ...) {
  chk_s3_class(x2, "mcmcr")

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(pars(x), pars(x2))) {
    abort_chk("`x` and `x2` must have the same parameters")
  }

  if (!identical(pdims(x), pdims(x2))) {
    abort_chk("`x` and `x2` must have the same parameter dimensions")
  }

  if (!identical(niters(x), niters(x2))) {
    abort_chk("`x` and `x2` must have the same number of iterations")
  }

  x <- mapply(x, x2, FUN = bind_chains, SIMPLIFY = FALSE)
  set_class(x, "mcmcr")
}
