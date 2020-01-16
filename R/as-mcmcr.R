#' Convert to an mcmcr Object
#'
#' Converts an MCMC object to an \code{\link{mcmcr-object}}.
#'
#' @param x An MCMC object.
#' @param name A string specifying the parameter name.
#' @param ... Unused.
#' @return An mcmcr object.
#' @export
#'
#' @examples
#' mcmc.list <- coda::as.mcmc.list(mcmcr::mcmcr_example)
#' as.mcmcr(mcmc.list)
as.mcmcr <- function(x, ...) UseMethod("as.mcmcr")

#' @describeIn as.mcarray Convert a list of uniquely named objects that can be coerced to \code{\link{mcmcarray-object}s} to an mcmcr object
#' @export
as.mcmcr.list <- function(x, ...) {
  chk_not_empty(x)
  chk_named(x)
  chk_unique(names(x))

  x <- lapply(x, as.mcmcarray)

  nchains <- vapply(x, nchains, 1L)
  niters <- vapply(x, niters, 1L)

  if (!identical(length(unique(nchains)), 1L))
    err("all objects must have the same number of chains")

  if (!identical(length(unique(niters)), 1L))
    err("all objects must have the same number of iterations")

  set_class(x, "mcmcr")
}

#' @describeIn as.mcmcr Convert an mcarray object to an mcmcr object
#' @export
as.mcmcr.mcarray <- function(x, name = "par", ...) {
  chk_unused(...)
  as.mcmcr(as.mcmcarray(x), name = name)
}

#' @describeIn as.mcmcr Convert an \code{\link{mcmcarray-object}} to an mcmcr object
#' @export
as.mcmcr.mcmcarray <- function(x, name = "par", ...) {
  chk_string(name)
  chk_unused(...)
  x <- list(x)
  names(x) <- name
  set_class(x, "mcmcr")
}

#' @describeIn as.mcmcr Convert an \code{\link[nlist]{nlist-object}} to an mcmcr object
#' @export
as.mcmcr.nlist <- function(x, ...) {
  x <- lapply(x, as.mcmcarray)
  set_class(x, "mcmcr")
}

#' @describeIn as.mcmcr Convert an \code{\link[nlist]{nlists-object}} to an mcmcr object
#' @export
as.mcmcr.nlists <- function(x, ...) {
  x <- purrr::transpose(x)
  x <- lapply(x, bind_iterations_mcmcarrays)
  set_class(x, "mcmcr")
}

#' @describeIn as.mcmcr Convert an \code{\link[coda]{mcmc}} object to an mcmcr object
#' @export
as.mcmcr.mcmc <- function(x, ...) {
  pars <- pars(x)
  x <- lapply(pars, function(p, x) subset(x, pars = p), x = x)
  x <- lapply(x, as.mcmcarray)
  names(x) <- pars
  set_class(x, "mcmcr")
}

#' @describeIn as.mcmcr Convert an \code{\link[coda]{mcmc.list}} object to an mcmcr object
#' @export
as.mcmcr.mcmc.list <- function(x, ...) {
  x <- lapply(x, as.mcmcr)
  Reduce(bind_chains, x)
}

#' @export
as.mcmcr.mcmcr <- function(x, ...) x

#' @describeIn as.mcmcr Convert tan \code{\link[mcmcr]{mcmcrs-object}} to an mcmcr object
#' @export
as.mcmcr.mcmcrs <- function(x, ...) {
  if (!identical(length(x), 1L)) err("x must have one mcmcr object")
  x[[1]]
}
