#' Number of MCMC samples
#'
#' Gets the number of MCMC iterations (in a chain).
#'
#' @param x The object
#' @param ... Unused.
#' @return A count indicating the number of MCMC iterations.
#' @export
#' @examples
#' niters(mcmcr_example)
niters <- function(x, ...) {
  UseMethod("niters")
}

niters.matrix <- function(x, ...) ncol(x)

#' @describeIn nchains Number of MCMC iterations for an mcarray object
#' @export
niters.mcarray <- function(x, ...) unname(dim(x)[ndims(x) - 1])

#' @describeIn nchains Number of MCMC iterations for an mcmc object
#' @export
niters.mcmc <- function(x, ...) nrow(x)

#' @describeIn nchains Number of MCMC iterations for an mcmc.list object
#' @export
niters.mcmc.list <- function(x, ...) niters(x[[1]])

#' @describeIn nchains Number of MCMC iterations for an mcmcarray object
#' @export
niters.mcmcarray <- function(x, ...) dim(x)[2]

#' @describeIn nchains Number of MCMC iterations for an mcmcr object
#' @export
niters.mcmcr <- function(x, ...) niters(x[[1]])

#' @describeIn nchains Number of MCMC iterations for an mcmcrs object
#' @export
niters.mcmcrs <- function(x, ...) niters(x[[1]])
