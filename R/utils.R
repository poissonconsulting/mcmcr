#' Error
#'
#' Throws an error without the call as part of the error message.
#'
#' @inheritParams base::stop
#' @seealso base::stop
#' @export
error <- function(...) {
  stop(..., call. = FALSE)
}

#' Dims
#'
#' @param x A vector, matrix or array.
#' @return An integer vector of the dimensions.
#' @examples
#' dims(character())
#' dims(2:3)
#' dims(matrix(1:6, nrow = 2))
#' @export
dims <- function(x) {
  if (is.vector(x) || is.factor(x)) length(x) else dim(x)
}

#' Number of dimensions
#'
#' @param x The object to get the number of dimensions of.
#'
#' @return A count of the number of dimensions
#' @export
ndims <- function(x) {
  length(dims(x))
}

#' Number of MCMC Samples
#'
#' The product of the number of chains and number of iterations in each chain.
#'
#' @param x The object.
#'
#' @return A count of the total number of samples.
#' @export
nsamples <- function(x) {
  nchains(x) * niters(x)
}

#' Effective Sample Size
#'
#' The effective number of MCMC samples.
#'
#' @param x The object.
#'
#' @return A count of the effective total number of samples.
#' @export
neffsamples <- function(x) {
  as.integer(round(nsamples(x) * efs(x)))
}
