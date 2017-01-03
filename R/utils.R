check_unused <- function(...) {
  dots <- pryr::named_dots(...)
  if (length(dots)) error("dots are not unused")
  invisible(NULL)
}

error <- function(...) {
  stop(..., call. = FALSE)
}

ndims <- function(x) length(dim(x))

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
