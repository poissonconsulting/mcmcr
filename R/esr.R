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
#' @param x A vector, matrix (each row is a chain) or mcmc object.
#' @param ... Unused.
#' @return The esr value(s).
#' @examples
#' esr(rnorm(1000))
#' @export
esr <- function(x, ...) {
  UseMethod("esr")
}

#' @export
esr.numeric <- function(x, ...) {
  x <- acf(x, lag.max = length(x) - 1, plot = FALSE)$acf[,,1]

  if (is.nan(x[1])) return(1) # all values identical

  x <- c(x, -1)
  match <- match(TRUE, x < 0)
  x <- sum(x[1:(match-1)]) - 1
  x <- 1 / (1 + 2 * x)
  x <- round(x, 2)
  x
}

#' @export
esr.matrix <- function(x, ...) {
  niters <- niters(x)

  x %<>%
    apply(1L, esr) %>%
    unlist() %>%
    mean() %>%
    round(2)

  x
}

#' @export
esr.mcmcarray <- function(x, by = "all", ...) {
  check_scalar(by, c("all", "parameter", "term"))

  x %<>% estimates(fun = esr)

  if (!isTRUE(all.equal(by, "term"))) return(min(x))
  x
}

#' @export
esr.mcmcr <- function(x, by = "all", ...) {
  x %<>% purrr::map(esr, by = by)
  if (isTRUE(all.equal(by, "all"))) return(min(unlist(x)))
  x
}

#' @export
esr.mcmcrs <- function(x, by = "all", ...) {
  purrr::map(x, esr, by = by)
}
