#' @export
universals::collapse_chains

#' @inherit universals::collapse_chains
#' @export
collapse_chains.mcmcr <- function(x, ...) {
  x <- lapply(x, collapse_chains)
  set_class(x, "mcmcr")
}
