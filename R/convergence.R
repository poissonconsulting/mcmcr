#' Convergence
#'
#' Get R-hat value(s) for JAGS objects
#'
#' @param x An mcmc object.
#' @param ... Unused.
#' @return A number of the convergence value.
#' @export
convergence <- function(x, ...) {
  UseMethod("convergence", x)
}

#' @export
convergence.mcmcarray <- function(x, ...) {
  check_unused(...)

  if (nchains(x) < 2) error("x must have at least two chains")

  x %<>% normalize()

  M <- nchains(x)
  N <- niters(x)

  mu_w <- apply(x, c(1, 3:ndims(x)), mean)
  var_w <- apply(x, c(1, 3:ndims(x)), stats::var)

  mu <- apply(mu_w, 2:ndims(mu_w), mean)

  B <- (mu_w - mu)^2
  B <- apply(B, 2:ndims(B), mean)
  B <- B * N / (M - 1)

  W <- apply(var_w, 2:ndims(var_w), mean)

  V <- ((N - 1) / N * W) + ((M + 1) / (M * N) * B)

  d <- (2 * V) / stats::var(V)

  cf <- (d + 3) / (d + 1)

  rhat <- cf * (V / W)
  rhat %<>% sqrt()
  rhat
}

#' @export
convergence.mcmcr <- function(x, ...) {
  check_unused(...)
  convergence(as.mcmc.list(x))
}
