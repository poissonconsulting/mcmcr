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

  m <- nchains(x)
  n <- niters(x)

  W <- apply(x, 3:ndims(x), w)
  B <- apply(x, 3:ndims(x), bdn) * n

  V <- ((n - 1) / n * W) + (B / n) + (B / (m * n))

  var_w <- apply(x, c(1, 3:ndims(x)), stats::var)
  mu_w <- apply(x, c(1, 3:ndims(x)), mean)

  var_mu_w <- abind::abind(var_w, mu_w, along = 0)
  var_mu2_w <- abind::abind(var_w, (mu_w)^2, along = 0)

  var <- apply(var_w, 2:ndims(var_w), stats::var)
  mu <- apply(mu_w, 2:ndims(mu_w), mean)

  cov <- apply(var_mu_w, 3:ndims(var_mu_w), covar)
  cov2 <- apply(var_mu2_w, 3:ndims(var_mu2_w), covar)

  var_V <- (((n - 1) / n)^2 / m * var) +
    (((m + 1) / m * n)^2 * 2 / (m - 1) * B^2) +
    (2 * (m + 1) * (n - 1) / (m * n^2) * n / m * (cov2 - 2 * mu * cov))

  d <- (2 * V) / var_V

  cf <- (d + 3) / (d + 1)

  rhat <- cf * (V / W)
  rhat %<>% sqrt()
  rhat
}

#' @export
convergence.mcmcr <- function(x, ...) {
  check_unused(...)
  x %<>% vapply(function(x) max(convergence(x)), 1)
  max(x)
}
