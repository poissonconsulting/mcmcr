#' Effective Sampling
#'
#' @param x An mcmc object.
#' @param ... Unused.
#' @return A number of the esr value.
#' @export
esr <- function(x, ...) {
  UseMethod("esr")
}

#' @export
esr.matrix <- function(x, ...) {
  niters <- niters(x)

  x %<>%
    apply(1L, acf, lag.max = niters - 1, plot = FALSE) %>%
    lapply(function(x) x$acf[,,1]) %>%
    lapply(function(x) c(x, -1)) %>%
    lapply(function(x) x[1:match(TRUE, x < 0)]) %>%
    lapply(function(x) sum(x[-length(x)])) %>%
    unlist() %>%
    mean()

  if (is.nan(x)) return(1)

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
