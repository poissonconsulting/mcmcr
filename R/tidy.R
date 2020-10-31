#' @export
generics::tidy

#' @inheritParams nlist::tidy.nlist
#'
#' @export
tidy.mcmcr <- function(x, simplify = FALSE, ...) {
  chk_unused(...)
  tidy(as_mcmc_list(x), simplify = simplify)
}
