#' Effective Sampling Rate
#'
#' Calculates the effective sampling rate (\code{esr}) based on the formula
#' \deqn{\frac{1}{1 + 2 \sum_{k = 1}^\infty\rho_k(\theta)}}
#' in Brooks et al. (2011).
#' The infinite sum is truncated at
#' lag \eqn{k} when \eqn{\rho_{k+1}(\theta) < 0}.
#'
#' @references
#' Brooks, S., Gelman, A., Jones, G.L., and Meng, X.-L. (Editors). 2011. Handbook for Markov Chain Monte Carlo. Taylor & Francis, Boca Raton.
#'
#' @param x An mcmc object.
#' @param ... Unused.
#' @return The esr value(s).
#' @export
#' @examples
#' esr(mcmcr_example)
esr <- function(x, ...) {
  UseMethod("esr")
}

#' @export
esr.numeric <- function(x, ...) {
  x <- stats::acf(x, lag.max = length(x) - 1, plot = FALSE)$acf[,,1]

  if (is.nan(x[1])) return(1) # all values identical

  x <- c(x, -1)
  match <- match(TRUE, x < 0)
  x <- sum(x[1:(match-1)]) - 1
  x <- 1 / (1 + 2 * x)
  round(x, 2)
}

#' @export
esr.matrix <- function(x, ...) {
  niters <- niters(x)
  x <- apply(x, 1L, esr)
  x <- unlist(x)
  x <- mean(x)
  round(x, 2)
}

#' @export
esr.mcmcarray <- function(x, by = "all", ...) {
  check_vector(by, c("all", "parameter", "term"), length = 1)

  x <- estimates(x, fun = esr)

  if (!isTRUE(all.equal(by, "term"))) return(min(x))
  x
}

#' @export
esr.mcmcr <- function(x, by = "all", ...) {
  x <- lapply(x, esr, by = by)
  if (isTRUE(all.equal(by, "all"))) return(min(unlist(x)))
  x
}

#' @export
esr.mcmcrs <- function(x, by = "all", ...) {
  lapply(x, esr, by = by)
}
