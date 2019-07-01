#' Coerce to an mcmcr object
#'
#' Coerces MCMC objects to an \code{\link{mcmcr-object}}.
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
#' @examples
#' as.mcmcr(coda::as.mcmc.list(mcmcr_example))
as.mcmcr <- function(x, ...) UseMethod("as.mcmcr")

#' @export
as.mcmcr.nlists <- function(x, ...) {
  x <- purrr::transpose(x)
  x <- lapply(x, bind_iterations_mcmcarrays)
  set_class(x, "mcmcr")
}

#' @export
as.mcmcr.list <- function(x, ...) {
  check_length(x)
  check_named(x, unique = TRUE)

  x <- lapply(x, as.mcmcarray)

  nchains <- vapply(x, nchains, 1L)
  niters <- vapply(x, niters, 1L)

  if (!identical(length(unique(nchains)), 1L))
    err("all objects must have the same number of chains")

  if (!identical(length(unique(niters)), 1L))
    err("all objects must have the same number of iterations")

  set_class(x, "mcmcr")
}

#' @export
as.mcmcr.mcarray <- function(x, ...) as.mcmcr(as.mcmcarray(x))

#' @export
as.mcmcr.mcmc <- function(x, ...) {
  pars <- pars(x)
  x <- lapply(pars, function(p, x) subset(x, parameters = p), x = x)
  x <- lapply(x, as.mcmcarray)
  names(x) <- pars
  set_class(x, "mcmcr")
}

#' @export
as.mcmcr.mcmc.list <- function(x, ...) {
  x <- lapply(x, as.mcmcr)
  Reduce(bind_chains, x)
}

#' @export
as.mcmcr.mcmcarray <- function(x, ...) set_class(list(x), "mcmcr")

#' @export
as.mcmcr.mcmcr <- function(x, ...) x
