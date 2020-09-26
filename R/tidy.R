#' @export
generics::tidy

#' @inherit generics::tidy
#'
#' @export
tidy.mcmc.mcmcr <- function(x, ...) {
  chk_unused(...)
  tidy(as_nlists(x))
}
