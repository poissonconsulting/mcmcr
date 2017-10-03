#' Effective Sampling Proportion
#'
#' @param x An mcmc object.
#' @param ... Unused.
#' @return A number of the esp value.
#' @export
esp <- function(x, ...) {
  UseMethod("esp")
}

#' @export
esp.matrix <- function(x, ...) {
  niters <- niters(x)
  nchains <- nchains(x)

  x %<>%
    apply(1L, acf, lag.max = niters - 1, plot = FALSE) %>%
    lapply(function(x) x$acf[,,1]) %>%
    lapply(function(x) x[1:match(TRUE, x < 0)]) %>%
    lapply(function(x) sum(x[-length(x)])) %>%
    unlist() %>%
    mean()

  x <- 1 / (1 + (2 * (x - 1)))

  round(x, 2)
}

#' @export
esp.mcmcarray <- function(x, by = "all", ...) {
  check_scalar(by, c("all", "parameter", "term"))

  x %<>%
    estimates(fun = esp) %>%
    round(2)

  if (!isTRUE(all.equal(by, "term"))) return(min(x))
  x
}

#' @export
esp.mcmcr <- function(x, by = "all", ...) {
  x %<>% purrr::map(esp, by = by)
  if (isTRUE(all.equal(by, "all"))) return(min(unlist(x)))
  x
}

#' @export
esp.mcmcrs <- function(x, by = "all", ...) {
  x %<>% purrr::reduce(bind_chains)
  esp(x, by = by)
}
