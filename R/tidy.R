#' @export
generics::tidy

#' @inheritParams nlist::tidy.nlist
#' @inheritParams params
#'
#' @export
tidy.mcmcr <- function(
  x,
  simplify = FALSE,
  directional_information = FALSE,
  ...
) {
  chk_unused(...)
  if (missing(directional_information)) {
    warn_default_directional_information("tidy")
  }
  tidy(
    as_mcmc_list(x),
    simplify = simplify,
    directional_information = directional_information
  )
}
