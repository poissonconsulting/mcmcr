#' @export
npars.mcmc <- function(x, repair = TRUE, ...) {
  check_flag(repair)
  check_unused(...)
  npars(as.term(x), repair = repair)
}

#' @export
npars.mcmc.list <- function(x, repair = TRUE, ...) {
  check_unused(...)
  npars(x[[1]], repair = repair)
}

#' @export
npars.mcarray <- function(x, ...) 1L

#' @export
npars.mcmcarray <- function(x, ...) 1L

#' @export
npars.mcmcr <- function(x, ...) length(x)

#' @export
npars.mcmcrs <- function(x, ...) npars(x[[1]])
