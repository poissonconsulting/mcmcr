#' Dimensions
#'
#' @param x The object.
#' @return An integer vector of the dimensions.
#' @examples
#' dims(character())
#' dims(2:3)
#' dims(matrix(1:6, nrow = 2))
#' @export
dims <- function(x) if (is.vector(x) || is.factor(x)) length(x) else dim(x)

#' Number of dimensions
#'
#' @param x The object.
#'
#' @return A count of the number of dimensions
#' @export
ndims <- function(x) {
  length(dims(x))
}

#' Number of MCMC Simulations
#'
#' The product of the number of chains and number of iterations in each chain.
#'
#' @param x The object.
#'
#' @return A count of the total number of simulations.
#' @export
nsims <- function(x) {
  nchains(x) * niters(x)
}

#' Number of MCMC Samples
#'
#' The product of the number of simulations and the number of terms.
#'
#' @param x The object.
#'
#' @return A count of the total number of samples.
#' @export
nsams <- function(x) {
  nterms(x) * nsims(x)
}

#' Terms
#'
#' @param x The object
#' @export
terms <- function(x) {
  as.term(x)
}
