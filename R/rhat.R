#' Rhat
#'
#' Calculates uncorrected, untransformed, univariate
#' split R-hat (potential scale reduction factor) values.
#' @references
#' Gelman, A., and Rubin, D.B. 1992. Inference from Iterative Simulation Using Multiple Sequences. Statistical Science 7(4): 457–472.
#' @param x An mcmc object.
#' @param ... Unused.
#' @return The rhat value(s).
#' @export
#' @examples
#' rhat(mcmcr_example)
#' rhat(mcmcr_example, by = "parameter")
#' rhat(mcmcr_example, by = "term")
rhat <- function(x, ...) {
  UseMethod("rhat")
}

#' @export
rhat.matrix <- function(x, ...) {
  mean_chain <- apply(x, 1L, mean)
  var_chain <- apply(x, 1L, stats::var)

  niters <- niters(x)

  var_between <- niters * stats::var(mean_chain)
  var_within <- mean(var_chain)
  rhat <- sqrt((var_between/var_within + niters - 1) / niters)

  if (is.nan(rhat)) rhat <- 1
  rhat
}

#' @export
rhat.mcmcarray <- function(x, by = "all", ...) {
  check_vector(by, c("all", "parameter", "term"), length = 1)

  x <- split_chains(x)
  x <- estimates(x, fun = rhat)
  x <- round(x, 2)

  if (!isTRUE(all.equal(by, "term"))) return(max(x))
  x
}

#' @export
rhat.mcmcr <- function(x, by = "all", ...) {
  x <- lapply(x, rhat, by = by)
  if (isTRUE(all.equal(by, "all"))) return(max(unlist(x)))
  x
}

#' @export
rhat.mcmcrs <- function(x, by = "all", ...) {
  lapply(x, rhat, by = by)
}
