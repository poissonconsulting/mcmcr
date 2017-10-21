#' MCMC map
#'
#' Map mcmc values
#'
#' @param .x The mcmc object.
#' @param .f The function to use
#' @param ... Additional arguments passed to .f.
#' @return The mapped mcmc object.
#' @export
mcmc_map <- function(.x, .f, ...) {
  UseMethod("mcmc_map")
}

#' @export
mcmc_map.mcmcarray <- function(.x, .f, ...) {
  x <- .f(.x, ...)
  if(!identical(dims(x), dims(.x))) error("mcmc_map function .f failed to retun a scalar")
  x
}

#' @export
mcmc_map.mcmcr <- function(.x, .f, ...) {
  for(i in seq_along(.x))
    .x[[i]] %<>% mcmc_map(.f = .f , ...)
  .x
}
