#' Combines object values.
#'
#' Combines two or more mcmc objects by values using fun.
#'
#' @param x an mcmc object.
#' @param x2 a second mcmc object.
#' @param fun A function.
#' @param ... Unused.
#' @export
combine_values <- function(x, x2, fun = mean, ...) {
  UseMethod("combine_values", x)
}

#' @export
combine_values.mcmcarray <- function(x, x2, fun = mean, ...) {
  check_unused(...)
  if (!is.mcmcarray(x)) error("x2 must be an mcmcarray")

  dim <- dim(x)
  dim2 <- dim(x2)

  if (!identical(dim, dim2)) error("x and x2 must have the same dimensions")

  x %<>% fun(x2)
  class(x) <- "mcmcarray"
  x
}
