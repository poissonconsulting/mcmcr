#' Combines objects by samples
#'
#' Combines two or more mcmc objects by samples
#'
#' @param x an mcmc object.
#' @param x2 a second mcmc object.
#' @param along The dimension(s) of the samples along which to bind the arrays.
#' @param ... Unused.
#' @export
bind_samples <- function(x, x2, along = NULL, ...) {
  UseMethod("bind_samples")
}

#' @export
bind_samples.mcmcarray <- function(x, x2, along = NULL, ...) {

  if (!is.mcmcarray(x)) error("x2 must be an mcmcarray")

  dim <- dim(x)
  dim2 <- dim(x2)

  if (!identical(dim[1:2], dim2[1:2]))
    error("x and x2 must have the same number of chains and iterations")

  if (is.null(along)) along <- max(ndims(x), ndims(x2)) - 2

  check_number(along)

  x %<>% abind::abind(x2, along = along)
  class(x) <- "mcmcarray"
  x
}

#' @export
bind_samples.mcmcr <- function(x, x2, along = NULL, ...) {

  if (!is.mcmcr(x)) error("x2 must be an mcmcr")

  if (!identical(names(x), names(x2))) error("x and x2 must have the same names")

  if (is.null(along)) {
    along <- purrr::map2(x, x2, function(x, x2) {max(ndims(x), ndims(x2)) - 2})
  } else if (length(along)  == 1) {
    along %<>% rep(length(x))
  } else if (length(along) != length(x))
    error("along must be a number or a vector of numbers the same length as the number of parameters in x")

  check_vector(along, value = 1)

  x <- list(x = x, x2 = x2, along = as.list(along))
  x %<>% purrr::transpose()

  x %<>% purrr::pmap(bind_samples)
  class(x) <- "mcmcr"
  x
}
