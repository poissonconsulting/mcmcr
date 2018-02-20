#' Number of MCMC samples in a single chain
#'
#' @param x The object
#' @param ... Unused.
#' @return A count indicating the number of MCMC samples in a chain.
#' @export
#' @examples
#' niters(mcmcr_example)
niters <- function(x, ...) {
  UseMethod("niters")
}

niters.matrix <- function(x, ...) ncol(x)

#' @export
niters.mcarray <- function(x, ...) unname(dim(x)[ndims(x) - 1])

#' @export
niters.mcmc <- function(x, ...) {
  if (is.matrix(x)) return(nrow(x))
  length(x)
}

#' @export
niters.mcmc.list <- function(x, ...) niters(x[[1]])

#' @export
niters.mcmcarray <- function(x, ...) dim(x)[2]

#' @export
niters.mcmcr <- function(x, ...) niters(x[[1]])

#' @export
niters.mcmcrs <- function(x, ...) niters(x[[1]])
