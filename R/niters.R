#' Number of MCMC samples
#'
#' Gets the number of MCMC iterations (in a chain).
#'
#' @param x The object
#' @param ... Unused.
#' @return A count indicating the number of MCMC iterations.
#' @name niters
#' @export
#' @examples
#' niters(mcmcr_example)
NULL

niters.matrix <- function(x, ...) ncol(x)

#' @describeIn niters Number of MCMC iterations for an mcarray object
#' @export
niters.mcarray <- function(x, ...) unname(dim(x)[ndims(x) - 1])

#' @describeIn niters Number of MCMC iterations for an mcmc object
#' @export
niters.mcmc <- function(x, ...) nrow(x)

#' @describeIn niters Number of MCMC iterations for an mcmc.list object
#' @export
niters.mcmc.list <- function(x, ...) niters(x[[1]])

#' @describeIn niters Number of MCMC iterations for an mcmcarray object
#' @export
niters.mcmcarray <- function(x, ...) dim(x)[2]

#' @describeIn niters Number of MCMC iterations for an mcmcr object
#' @export
niters.mcmcr <- function(x, ...) niters(x[[1]])

#' @describeIn niters Number of MCMC iterations for an mcmcrs object
#' @export
niters.mcmcrs <- function(x, ...) niters(x[[1]])
