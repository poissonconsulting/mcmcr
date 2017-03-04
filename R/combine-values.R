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

combine_values_mcmcarray_list <- function(x, fun) {
  if (!all(vapply(x, is.mcmcarray, TRUE))) error("objects in x must be of class mcmcarray")

  dim <- lapply(x, dim)
  names(dim) <- NULL

  print(dim)
  if (!identical(dim, rep(dim[1], length(x))))
    error("objects in x must have the same dimensions")

  x %<>% abind::abind(along = 0)

  x %<>% apply(2:ndims(x), fun)

  if (!identical(dim[[1]], dim(x))) error("function fun must return a scalar")

  class(x) <- "mcmcarray"
  x
}

#' @export
combine_values.mcmcarray <- function(x, x2, fun = mean, ...) {

  if (!is.mcmcarray(x2)) error("x2 must be an mcmcarray")

  if (!identical(dim(x), dim(x2))) error("x and x2 must have the same dimensions")

  x %<>% abind::abind(x2, along = 0)

  x %<>% apply(2:ndims(x), fun)

  if (!identical(dim(x), dim(x2))) error("function fun must return a scalar")

  class(x) <- "mcmcarray"
  x
}

#' @export
combine_values.mcmcr <- function(x, x2, fun = mean, ...) {

  if (!is.mcmcr(x2)) error("x2 must be an mcmcr")

  if (!identical(names(x), names(x2))) error("x and x2 must have the same names")

  x %<>% purrr::map2(x2, combine_values, fun = fun, ...)

  class(x) <- "mcmcr"
  x
}

#' @export
combine_values.list <- function(x, x2, fun = mean, ...) {

  if (!missing(x2)) error("if x is a list x2 must be missing")

  if (!all(vapply(x, is.mcmcr, TRUE))) error("objects in x must be of class mcmcr")

  names <- lapply(x, names)
  if (!all.equal(names, rep(names[1], length(x)), check.names = FALSE)) error("objects in x must have the same names")

  x %<>% purrr::transpose()

  x %<>% lapply(combine_values_mcmcarray_list, fun = fun)

  class(x) <- "mcmcr"
  x
}
