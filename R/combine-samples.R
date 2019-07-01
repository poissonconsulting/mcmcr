#' Combine MCMC Samples of Two Objects
#'
#' Combines samples of two MCMC objects
#' (with the same parameters, chains and iterations) using a function.
#'
#' @param x An MCMC object.
#' @param x2 A second MCMC object.
#' @param fun The function to use to combine the samples.
#' The function must return a scalar.
#' @param ... Unused.
#' @return The combined samples as an MCMC object
#' with the same parameters, chains and iterations as the original objects.
#' @export
#' @examples
#' combine_samples(mcmcr_example, mcmcr_example, fun = sum)
combine_samples <- function(x, x2, fun = mean, ...) {
  UseMethod("combine_samples")
}

#' @export
combine_samples.mcmcarray <- function(x, x2, fun = mean, ...) {
  if (!is.mcmcarray(x2)) err("x2 must be an mcmcarray")
  check_function(fun)

  x <- bind_dimensions(x, x2)
  x <- apply(x, (2:ndims(x) - 1L), fun)

  if(!identical(dims(x), dims(x2))) err("function fun must return a scalar")
  set_class(x, "mcmcarray")
}

#' @export
combine_samples.mcmcr <- function(x, x2, fun = mean, ...) {
  if (!is.mcmcr(x2)) err("x2 must be an mcmcr")
  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(pdims(x), pdims(x2)))
    err("x and x2 must have the same parameter dimensions")

  x <- bind_dimensions(x, x2)
  x <- lapply(x, function(x, fun) {apply(x, (2:ndims(x) - 1L), fun)}, fun = fun)
  x <- lapply(x, function(x) set_class(x, "mcmcarray"))
  x <- set_class(x, "mcmcr")

  if (!identical(pdims(x), pdims(x2)))
    err("function fun must return a scalar")
  x
}
