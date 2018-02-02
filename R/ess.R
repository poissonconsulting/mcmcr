#' Effective Sample Size
#'
#' @param x An mcmc object.
#' @param ... Unused.
#' @return A number of the ess value.
#' @export
ess <- function(x, ...) {
  UseMethod("ess")
}

#' @export
ess.matrix <- function(x, ...) {
  niters(x) * nchains(x) * esr(x)
}

#' @export
ess.mcmcarray <- function(x, by = "all", ...) {
  check_vector(by, c("all", "parameter", "term"), length = 1)

  x %<>%
    estimates(fun = ess) %>%
    round()

  storage.mode(x) <- "integer"

  if (!isTRUE(all.equal(by, "term"))) return(min(x))

  x
}

#' @export
ess.mcmcr <- function(x, by = "all", ...) {
  x %<>% purrr::map(ess, by = by)
  if (isTRUE(all.equal(by, "all"))) return(min(unlist(x)))
  x
}

#' @export
ess.mcmcrs <- function(x, by = "all", ...) {
  purrr::map(x, ess, by = by)
}
