#' Coerce to an mcmcrs object
#'
#' Coerces MCMC objects to an \code{\link{mcmcrs-object}}.
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
#' @examples
#' as.mcmcrs(list(mcmcr_example))
as.mcmcrs <- function(x, ...) UseMethod("as.mcmcrs")

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

#' @export
as.mcmcrs.mcmcrs <- function(x, ...) x
