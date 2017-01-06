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
  
  if (!is.mcmcarray(x)) error("x2 must be an mcmcarray")

  dim <- dim(x)
  dim2 <- dim(x2)

  if (!identical(dim, dim2)) error("x and x2 must have the same dimensions")

  x %<>% abind::abind(x2, along = 0)

  x %<>% apply(2:ndims(x), fun)

  class(x) <- "mcmcarray"
  x
}
