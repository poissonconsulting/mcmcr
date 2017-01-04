check_unused <- function(...) {
  dots <- pryr::named_dots(...)
  if (length(dots)) error("dots are not unused")
  invisible(NULL)
}

dprint <- function(x) {
  print(deparse(substitute(x)))
  print(x)
}

error <- function(...) {
  stop(..., call. = FALSE)
}

normalize <- function(x) {
  if (min(x) > 0) {
    if (max(x) < 1) {
      x <- logit(x)
    } else
      x <- log(x)
  }
  x
}

logit <- function(x) {
  log(x / (1 - x))
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

w <- function(x) mean(apply(x, 1, stats::var))

bdn <- function(x) {
  mu_w <- apply(x, 1, mean)
  mu <- mean(mu_w)
  sum((mu_w - mu)^2) / (length(mu_w) - 1)
}

covar <- function (x) stats::cov(x[1,], x[2,])


