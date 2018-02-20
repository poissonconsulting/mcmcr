#' Is Converged
#'
#' Tests whether x has converged.
#'
#' @param x The object to test.
#' @param ... Unused
#' @return A flag indicating whether the test was positive.
#' @export
#' @examples
#' converged(mcmcr_example)
converged <- function(x, ...) {
  UseMethod("converged")
}

#' @export
converged.matrix <- function(x, rhat = 1.1, esr = 0.33, ...) {
  check_vector(rhat, c(1.0, 1.5), length = 1)
  check_probability(esr)

  rhat(x) <= rhat && esr(x) >= esr
}

#' @export
converged.mcmcarray <- function(x, by = "all", rhat = 1.1, esr = 0.33, ...) {
  check_vector(by, c("all", "parameter", "term"), length = 1)
  x <- estimates(x, fun = converged, rhat = rhat, esr = esr)

  if (!isTRUE(all.equal(by, "term"))) return(all(x))
  x
}

#' @export
converged.mcmcr <- function(x, by = "all", rhat = 1.1, esr = 0.33, ...) {
  x <- lapply(x, converged, by = by, rhat = rhat, esr = esr)
  if (isTRUE(all.equal(by, "all"))) return(all(unlist(x)))
  x
}

#' @export
converged.mcmcrs <- function(x, by = "all", rhat = 1.1, esr = 0.33, ...) {
  lapply(x, converged, by = by, rhat = rhat, esr = esr)
}
