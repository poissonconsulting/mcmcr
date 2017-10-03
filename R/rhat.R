#' Rhat
#'
#' Gets uncorrected, untransformed, univariate split R-hat value(s).
#'
#' @param x An mcmc object.
#' @param ... Unused.
#' @return A number of the rhat value.
#' @export
rhat <- function(x, ...) {
  UseMethod("rhat")
}

#' @export
rhat.matrix <- function(x, ...) {
  mean_chain <- apply(x, 1L, mean)
  var_chain <- apply(x, 1L, var)

  niters <- niters(x)

  var_between <- niters * var(mean_chain)
  var_within <- mean(var_chain)
  rhat <- sqrt((var_between/var_within + niters - 1) / niters)
  rhat
}

#' @export
rhat.mcmcarray <- function(x, by = "all", ...) {
  check_scalar(by, c("all", "parameter", "term"))

  x %<>%
    split_chains() %>%
    estimates(fun = rhat) %>%
    round(2)

  if (!isTRUE(all.equal(by, "term"))) return(max(x))
  x
}

#' @export
rhat.mcmcr <- function(x, by = "all", ...) {
  x %<>% purrr::map(rhat, by = by)
  if (isTRUE(all.equal(by, "all"))) return(max(unlist(x)))
  x
}

#' @export
rhat.mcmcrs <- function(x, by = "all", ...) {
  x %<>% purrr::reduce(bind_chains)
  rhat(x, by = by)
}
