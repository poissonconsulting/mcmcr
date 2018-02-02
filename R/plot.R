# modified from coda set.mfrow
mfrow <- function(nterms = 1) {
  mfrow <- switch(min(nterms, 13),
                  c(1, 2), c(2, 2),
                  c(3, 2), c(4, 2), c(3, 2), c(3, 2), c(4, 2),
                  c(4, 2), c(4, 2), c(3, 2), c(3, 2), c(3, 2),
                  c(4, 2))
  return(mfrow)
}

#' @export
plot.mcmcarray <- function(x, ...) {


  nterms <- nterms(x)

  mfrow <- mfrow(nterms)

  op <- graphics::par(mfrow = mfrow)
  on.exit(graphics::par(op))

  x <- as.mcmc.list(x)

  for (i in 1:nterms) {
    coda::traceplot(x[, i, drop = FALSE], smooth = TRUE)
    coda::densplot(x[, i, drop = FALSE])
  }
  invisible()
}

#' @export
plot.mcmcr <- function(x, ...) {

  nterms <- nterms(x)

  mfrow <- mfrow(nterms)

  op <- graphics::par(mfrow = mfrow)
  on.exit(graphics::par(op))

  x <- as.mcmc.list(x)

  for (i in 1:nterms) {
    coda::traceplot(x[, i, drop = FALSE], smooth = TRUE)
    coda::densplot(x[, i, drop = FALSE])
  }
  invisible()
}
