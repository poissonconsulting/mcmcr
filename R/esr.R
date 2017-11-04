#' Effective Sampling Rate
#'
#' Calculates the effective sampling rate (esr) based on the formula
#' \deqn{\frac{1}{1 + 2 \sum_{k = 1}^\infty\rho_k(\theta)}}
#' in the Handbook for Markov Chain Monte Carlo.
#'
#' The infinite sum is truncated at lag \eqn{k} when \eqn{\rho_k(θ) < 0}.
#'
#' @param x An mcmc object.
#' @param ... Unused.
#' @return A number of the esr value.
#' @export
#' @references
#' Brooks, S., Gelman, A., Jones, G.L., and Meng, X.-L. (Editors). 2011. Handbook for Markov Chain Monte Carlo. Taylor & Francis, Boca Raton.
esr <- function(x, ...) {
  UseMethod("esr")
}

#' @export
esr.numeric <- function(x, ...) {
  x <- acf(x, lag.max = length(x) - 1, plot = FALSE)
  x <-  x$acf[,,1]

  match <- match(TRUE, c(x,-1) < 0)
  x <- sum(x[1:(match-1)])
  if (is.nan(x)) return(1)
  x
}

#' @export
esr.matrix <- function(x, ...) {
  niters <- niters(x)

  x %<>%
    apply(1L, esr) %>%
    unlist() %>%
    mean()

  x <- 1 / (1 + (2 * (x - 1)))
  x
}

#' @export
esr.mcmcarray <- function(x, by = "all", ...) {
  check_scalar(by, c("all", "parameter", "term"))

  x %<>%
    estimates(fun = esr) %>%
    round(2)

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
