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
#' rhat(mcmcr_example, by = "term", as_df = TRUE)
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
rhat.mcarray <- function(x, by = "all", as_df = FALSE, ...)
  rhat(as.mcmcarray(x), by = by, as_df = as_df)

#' @export
rhat.mcmc <- function(x, by = "all", as_df = FALSE, ...)
  rhat(as.mcmcr(x), by = by, as_df = as_df)

#' @export
rhat.mcmc.list <- function(x, by = "all", as_df = FALSE, ...)
  rhat(as.mcmcr(x), by = by, as_df = as_df)

#' @export
rhat.mcmcarray <- function(x, by = "all", as_df = FALSE, ...) {
  check_vector(by, c("all", "parameter", "term"), length = 1)
  check_flag(as_df)

  x <- split_chains(x)
  x <- estimates(x, fun = rhat)
  x <- round(x, 2)

  if(!as_df) {
    if(by == "term") return(x)
    return(max(x))
  }
  if(by != "term")
    return(tibble::tibble(parameter = "parameter", rhat = max(x)))
  x <- estimates(as.mcmcarray(x), as_df = TRUE)
  colnames(x) <- c("term", "rhat")
  x
}

#' @export
rhat.mcmcr <- function(x, by = "all", as_df = FALSE, ...) {
  parameters <- parameters(x)
  x <- lapply(x, rhat, by = by, as_df = as_df)
  if(!as_df) {
    if (by != "all") return(x)
    return(max(unlist(x)))
  }
  if(by == "all")
    return(tibble::tibble(all = "all", rhat = max(unlist(x))))

  x <- Map(x, parameters, f = function(x, p) {parameters(x[[1]]) <- p; x})
  do.call(rbind, x)
}

#' @export
rhat.mcmcrs <- function(x, by = "all", as_df = FALSE, ...) {
  lapply(x, rhat, by = by, as_df = as_df)
}
