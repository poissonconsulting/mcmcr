#' Number of MCMC samples in a single chain
#'
#' @param x The object
#' @param ... Unused.
#' @return A count indicating the number of MCMC samples in a chain.
#' @export
niters <- function(x, ...) {
  UseMethod("niters")
}

#' @export
niters.mcmc <- function(x, ...) {
  if (is.matrix(x)) return(nrow(x))
  length(x)
}

#' @export
niters.mcmc.list <- function(x, ...) {
  if (is.matrix(x[[1]])) return(nrow(x[[1]]))
  length(x[[1]])
}

niters.matrix <- function(x, ...) {
  dim(x)[2]
}

#' @export
niters.mcarray <- function(x, ...) {
  niters <- dim(x)[ndims(x) - 1]
  names(niters) <- NULL
  niters
}

#' @export
niters.mcmcarray <- function(x, ...) {
  dim(x)[2]
}

#' @export
niters.mcmcr <- function(x, ...) {
  niters(x[[1]])
}
