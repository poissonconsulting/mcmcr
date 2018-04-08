#' MCMC Map
#'
#' Adjust the sample values of an MCMC object using a function.
#'
#' @param .x An MCMC object
#' @param .f The function to use
#' @param ... Additional arguments passed to .f.
#' @return The updated MCMC object.
#' @export
#' @examples
#' mcmc_map(mcmcr_example$beta, exp)
mcmc_map <- function(.x, .f, ...) {
  UseMethod("mcmc_map")
}

#' @describeIn mcmc_map Adjust the sample values of an MCMC object
#' @export
mcmc_map.default <- function(.x, .f, ...) {
  x <- .f(.x, ...)
  if(!identical(dims(x), dims(.x))) error("mcmc_map function .f failed to retun a scalar")
  x
}

#' @describeIn mcmc_map Adjust the sample values of an mcmc.list object
#' @export
mcmc_map.mcmc.list <- function(.x, .f, ...) {
  x <- lapply(.x, mcmc_map, .f = .f, ...)
  as.mcmc.list(x)
}

#' @describeIn mcmc_map Adjust the sample values of an mcmcr object
#' @export
mcmc_map.mcmcr <- function(.x, .f, ...) {
  x <- lapply(.x, mcmc_map, .f = .f, ...)
  set_class(x, "mcmcr")
}

#' @describeIn mcmc_map Adjust the sample values of an mcmcrs object
#' @export
mcmc_map.mcmcrs <- function(.x, .f, ...) {
  x <- lapply(.x, mcmc_map, .f = .f, ...)
  set_class(x, "mcmcrs")
}
