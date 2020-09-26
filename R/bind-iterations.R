#' @export
universals::bind_iterations

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
