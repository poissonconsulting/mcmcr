#' @export
generics::tidy

#' @inherit generics::tidy
#'
#' @export
tidy.mcmc <- function(x, ...) {
  chk_unused(...)
  tidy(as.nlists(x))
}

#' @inherit generics::tidy
#'
#' @export
tidy.mcmc.list <- function(x, ...) {
  chk_unused(...)
  tidy(as.nlists(x))
}

#' @inherit generics::tidy
#'
#' @export
tidy.mcmc.mcmcr <- function(x, ...) {
  chk_unused(...)
  tidy(as.nlists(x))
}
