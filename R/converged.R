#' Is Converged
#'
#' Tests whether x has converged.
#'
#' @param x The object to test.
#' @param ... Unused
#' @return A flag indicating whether the test was positive.
#' @export
converged <- function(x, ...) {
  UseMethod("converged")
}

#' @export
converged.matrix <- function(x, rhat = 1.1, esr = 0.33, ...) {
  check_scalar(rhat, 1.0, 1.5)
  check_scalar(esr, 0.0, 1.0)

  rhat(x) <= rhat && esr(x) >= esr
}

#' @export
converged.mcmcarray <- function(x, by = "all", rhat = 1.1, esr = 0.33, ...) {
  check_scalar(by, c("all", "parameter", "term"))
  x %<>%
    estimates(fun = converged, rhat = rhat, esr = esr)

  if (!isTRUE(all.equal(by, "term"))) return(all(x))

  x
}

#' @export
converged.mcmcr <- function(x, by = "all", rhat = 1.1, esr = 0.33, ...) {
  x %<>% purrr::map(converged, by = by, rhat = rhat, esr = esr)
  if (isTRUE(all.equal(by, "all"))) return(all(unlist(x)))
  x
}

#' @export
converged.mcmcrs <- function(x, by = "all", rhat = 1.1, esr = 0.33, ...) {
  purrr::map(x, converged, by = by, rhat = rhat, esr = esr)
}
