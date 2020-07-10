#' Combine multiple MCMC objects by parameter dimensions
#'
#' Combines multiple MCMC objects (with the same parameters, chains and iterations) by parameter dimensions.
#'
#' @param ... one or more MCMC objects
#' @export
#' @seealso [bind_dimensions()]
#' @examples
#' bind_dimensions_n(mcmcr_example, mcmcr_example, mcmcr_example)
bind_dimensions_n <- function(...) {
  UseMethod("bind_dimensions_n")
}

#' @export
bind_dimensions_n.mcmcarray <- function(...) {
  x <- list(...)

  if (!length(x)) abort_chk("one or more objects must be passed to bind_dimensions_n")

  if (length(x) == 1) {
    return(x[[1]])
  }

  pdims <- lapply(x, pdims)
  if (!all(vapply(pdims, identical, TRUE, pdims[[1]]))) {
    abort_chk("all objects must have the same parameter dimensions")
  }

  along <- pdims(x[[1]])
  along <- length(along) + 1L

  fun <- function(x1, x2) bind_dimensions(x1, x2, along = along)
  x <- Reduce(fun, x)
  x
}

#' @export
bind_dimensions_n.mcmcr <- function(...) {
  x <- list(...)

  if (!length(x)) abort_chk("one or more objects must be passed to bind_dimensions_n")

  if (length(x) == 1) {
    return(x[[1]])
  }

  pdims <- lapply(x, pdims)
  if (!all(vapply(pdims, identical, TRUE, pdims[[1]]))) {
    abort_chk("all objects must have the same parameter dimensions")
  }

  along <- pdims(x[[1]])
  along <- vapply(along, length, 1L) + 1L

  fun <- function(x1, x2) bind_dimensions(x1, x2, along = along)
  x <- Reduce(fun, x)
  x
}
