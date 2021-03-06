#' Combine MCMC samples of two objects
#'
#' Combines samples of two MCMC objects
#' (with the same parameters, chains and iterations) using a function.
#'
#' @inheritParams params
#' @param x An MCMC object.
#' @param fun The function to use to combine the samples.
#' The function must return a scalar.
#' @return The combined samples as an MCMC object
#' with the same parameters, chains and iterations as the original objects.
#' @family combine
#' @export
#' @examples
#' combine_samples(mcmcr_example, mcmcr_example, fun = sum)
combine_samples <- function(x, x2, fun = mean, ...) {
  UseMethod("combine_samples")
}

#' @export
combine_samples.mcmcarray <- function(x, x2, fun = mean, ...) {
  chk_s3_class(x2, "mcmcarray")
  chk_function(fun)

  x <- bind_dimensions(x, x2)
  x <- apply(x, (2:ndims(x) - 1L), fun)

  if (!identical(dims(x), dims(x2))) abort_chk("`fun` must return a scalar")
  set_class(x, "mcmcarray")
}

#' @export
combine_samples.mcmcr <- function(x, x2, fun = mean, ...) {
  chk_s3_class(x2, "mcmcr")
  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(pdims(x), pdims(x2))) {
    abort_chk("`x` and `x2` must have the same parameter dimensions")
  }

  x <- bind_dimensions(x, x2)
  x <- lapply(x, function(x, fun) {
    apply(x, (2:ndims(x) - 1L), fun)
  }, fun = fun)
  x <- lapply(x, function(x) set_class(x, "mcmcarray"))
  x <- set_class(x, "mcmcr")

  if (!identical(pdims(x), pdims(x2))) {
    abort_chk("`fun` must return a scalar")
  }
  x
}
