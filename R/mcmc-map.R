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
mcmc_map.default <- function(.x, .f, ...) {
  x <- .f(.x, ...)
  if(!identical(dims(x), dims(.x))) error("mcmc_map function .f failed to retun a scalar")
  x
}

#' @export
mcmc_map.mcmc.list <- function(.x, .f, ...) {
  x <- lapply(.x, mcmc_map, .f = .f, ...)
  coda::as.mcmc.list(x)
}

#' @export
mcmc_map.mcmcr <- function(.x, .f, ...) {
  x <- lapply(.x, mcmc_map, .f = .f, ...)
  set_class(x, "mcmcr")
}

#' @export
mcmc_map.mcmcrs <- function(.x, .f, ...) {
  x <- lapply(.x, mcmc_map, .f = .f, ...)
  set_class(x, "mcmcrs")
}

