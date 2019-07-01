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

#' @describeIn as.mcmcr Coerces list (of mcmcarray objects) to an mcmcr object
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

#' @describeIn as.mcmcr Coerces mcarray object to an mcmcr object
#' @export
as.mcmcr.mcarray <- function(x, ...) as.mcmcr(as.mcmcarray(x))

#' @describeIn as.mcmcr Coerces mcmc object to an mcmcr object
#' @export
as.mcmcr.mcmc <- function(x, ...) {
  parameters <- parameters(x)
  x <- lapply(parameters, function(p, x) subset(x, parameters = p), x = x)
  x <- lapply(x, as.mcmcarray)
  names(x) <- parameters
  set_class(x, "mcmcr")
}

#' @describeIn as.mcmcr Coerces mcmc.list object to an mcmcr object
#' @export
as.mcmcr.mcmc.list <- function(x, ...) {
  x <- lapply(x, as.mcmcr)
  Reduce(bind_chains, x)
}

#' @describeIn as.mcmcr Coerces mcmcarray object to an mcmcr object
#' @export
as.mcmcr.mcmcarray <- function(x, ...) set_class(list(x), "mcmcr")

#' @export
as.mcmcr.mcmcr <- function(x, ...) x
