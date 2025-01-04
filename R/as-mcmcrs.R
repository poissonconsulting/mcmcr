#' Convert to an mcmcrs object
#'
#' Converts an MCMC object to an [mcmcrs-object()].
#'
#' @inheritParams params
#' @param x An MCMC object.
#' @param name A string specifying the element name.
#' @return An mcmcrs object.
#' @export
#'
#' @examples
#' as.mcmcrs(mcmcr::mcmcr_example)
as.mcmcrs <- function(x, ...) UseMethod("as.mcmcrs")

#' @describeIn as.mcmcrs Convert a list of `[mcmcr-object]s` to an mcmcrs object
#' @export
as.mcmcrs.list <- function(x, ...) {
  chk_not_empty(x)
  chk_all(x, chk_s3_class, class = "mcmcr")

  nchains <- vapply(x, nchains, 1L)
  niters <- vapply(x, niters, 1L)
  pdims <- lapply(x, pdims)
  pars <- lapply(x, pars)

  if (!identical(length(unique(nchains)), 1L)) {
    abort_chk("all objects must have the same number of chains")
  }

  if (!identical(length(unique(niters)), 1L)) {
    abort_chk("all objects must have the same number of iterations")
  }

  if (!identical(length(unique(pars)), 1L)) {
    abort_chk("all objects must have the same parameters")
  }

  if (!identical(length(unique(pdims)), 1L)) {
    abort_chk("all objects must have the same parameter dimensions")
  }

  if (is.null(names(x))) {
    names(x) <- paste0("mcmcr", 1:length(x))
  } else if (anyDuplicated(names(x))) abort_chk("mcmcr objects must have unique names")
  set_class(x, "mcmcrs")
}

#' @describeIn as.mcmcrs Convert an [mcmcr-object()] to an mcmcrs object
#' @export
as.mcmcrs.mcmcr <- function(x, name = "mcmcr1", ...) {
  chk_string(name)
  chk_unused(...)

  x <- list(x)
  names(x) <- name
  set_class(x, "mcmcrs")
}

#' @export
as.mcmcrs.mcmcrs <- function(x, ...) x
