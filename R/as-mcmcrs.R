#' Convert to an mcmcrs object
#'
#' Converts an MCMC object to an \code{\link{mcmcrs-object}}.
#'
#' @param x An MCMC object.
#' @param name A string specifying the element name.
#' @param ... Unused.
#' @return An mcmcrs object.
#' @export
#'
#' @examples
#' as.mcmcrs(mcmcr::mcmcr_example)
as.mcmcrs <- function(x, ...) UseMethod("as.mcmcrs")

#' @describeIn as.mcmcrs Convert a list of \code{\link{mcmcr-object}s} to an mcmcrs object
#' @export
as.mcmcrs.list <- function(x, ...) {
  check_length(x)
  if (!all(vapply(x, is.mcmcr, TRUE)))
    err("all objects must inherit from mcmcr")

  nchains <- vapply(x, nchains, 1L)
  niters <- vapply(x, niters, 1L)
  pdims <- lapply(x, pdims)
  pars <- lapply(x, pars)

  if (!identical(length(unique(nchains)), 1L))
    err("all objects must have the same number of chains")

  if (!identical(length(unique(niters)), 1L))
    err("all objects must have the same number of iterations")

  if (!identical(length(unique(pars)), 1L))
    err("all objects must have the same parameters")

  if (!identical(length(unique(pdims)), 1L))
    err("all objects must have the same parameter dimensions")

  if(is.null(names(x))) {
    names(x) <- paste0("mcmcr", 1:length(x))
  } else
    if(anyDuplicated(names(x))) err("mcmcr objects must have unique names")
  set_class(x, "mcmcrs")
}

#' @describeIn as.mcmcrs Convert an \code{\link{mcmcr-object}} to an mcmcrs object
#' @export
as.mcmcrs.mcmcr <- function(x, name = "mcmcr1", ...) {
  check_string(name)
  check_unused(...)

  x <- list(x)
  names(x) <- name
  set_class(x, "mcmcrs")
}

#' @export
as.mcmcrs.mcmcrs <- function(x, ...) x
