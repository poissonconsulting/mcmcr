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
#' @param x An MCMC object
#' @param by A string indicating whether to return the estimates by
#' the object ("all"), "parameter" or "term"
#' @param as_df A flag indicating whether to return the estimates as a tibble versus a list.
#' @param ... Unused
#' @return The esr value(s) as a tibble or list
#' @export
#' @examples
#' esr(mcmcr_example)
esr <- function(x, ...) {
  UseMethod("esr")
}

#' @describeIn esr Effective Sampling Rate for an mcarray object
#' @export
esr.mcarray <- function(x, by = "all", ...) esr(as.mcmcarray(x), by = by)

#' @describeIn esr Effective Sampling Rate for an mcmc object
#' @export
esr.mcmc <- function(x, by = "all", ...) esr(as.mcmcr(x), by = by)

#' @describeIn esr Effective Sampling Rate for an mcmc.list object
#' @export
esr.mcmc.list <- function(x, by = "all", ...) esr(as.mcmcr(x), by = by)

#' @describeIn esr Effective Sampling Rate for an mcmcarray object
#' @export
esr.mcmcarray <- function(x, by = "all", as_df = FALSE, ...) {
  check_vector(by, c("all", "parameter", "term"), length = 1)

  x <- apply(x, 3:ndims(x), FUN = .esr)

  if(!as_df) {
    if(by == "term") return(x)
    return(min(x))
  }
  if(by != "term")
    return(tibble::tibble(parameter = "parameter", esr = min(x)))
  x <- estimates(as.mcmcarray(x), as_df = TRUE)
  colnames(x) <- c("term", "esr")
  x
}

#' @describeIn esr Effective Sampling Rate for an mcmcr object
#' @export
esr.mcmcr <- function(x, by = "all", as_df = FALSE, ...) {
  parameters <- parameters(x)
  x <- lapply(x, esr, by = by, as_df = as_df)
  if(!as_df) {
    if (by != "all") return(x)
    return(min(unlist(x)))
  }
  x <- Map(x, parameters, f = function(x, p) {parameters(x[[1]]) <- p; x})
  x <- do.call(rbind, x)
  if(by == "all")
    return(tibble::tibble(all = "all", esr = min(x$esr)))
  x
}

#' @describeIn esr Effective Sampling Rate for an mcmcrs object
#' @export
esr.mcmcrs <- function(x, by = "all", ...) {
  lapply(x, esr, by = by)
}
