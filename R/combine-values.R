#' Combines object values.
#'
#' Combines mcmc objects by values using fun.
#'
#' @param x An mcmc object.
#' @param x2 A second mcmc object.
#' @param fun A function.
#' @param ... Unused.
#' @export
combine_values <- function(x, x2, fun = mean, ...) {
  UseMethod("combine_values")
}

combine_values_mcmcarray <- function(x, fun) {
  if (!all(vapply(x, is.mcmcarray, TRUE))) error("objects in x must be of class mcmcarray")

  dim <- lapply(x, dim)
  names(dim) <- NULL

  if (!identical(dim, rep(dim[1], length(x))))
    error("objects in x must have the same dimensions")

  x <-abind::abind(x, along = 0)
  x <- apply(x, 2:ndims(x), fun)

  if (!identical(dim[[1]], dim(x))) error("function fun must return a scalar")

  class(x) <- "mcmcarray"
  x
}

combine_values_mcmcr <- function(x, fun) {
  if (!all(vapply(x, is.mcmcr, TRUE))) error("objects in x must be of class mcmcr")

  names <- lapply(x, names)
  if (!all.equal(names, rep(names[1], length(x)), check.names = FALSE)) error("objects in x must have the same names")

  x <- purrr::transpose(x)

  x <- lapply(x, combine_values_mcmcarray, fun = fun)

  class(x) <- "mcmcr"
  x
}

#' Combine list of mcmc samples
#'
#' @inheritParams combine_values
#' @export
combine_values_list <- function(x, fun = mean) {
  if (length(x) < 2) return(x)

  class <- class(x[[1]])

  x <- switch(class,
              mcmcr = combine_values_mcmcr(x, fun = fun),
              mcmcarray = combine_values_mcmcarray(x, fun = fun),
              stop("combine_values is not defined for a list of objects of class '", class, "'"))
  x
}

#' @export
combine_values.mcmcarray <- function(x, x2, fun = mean, ...) {
  if (!is.mcmcarray(x2)) error("x2 must be an mcmcarray")
  combine_values_list(list(x, x2), fun = fun)
}

#' @export
combine_values.mcmcr <- function(x, x2, fun = mean, ...) {
  if (!is.mcmcr(x2)) error("x2 must be an mcmcr")
  combine_values_list(list(x, x2), fun = fun)
}
