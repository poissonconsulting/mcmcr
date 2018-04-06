#' Combine two MCMC objects by dimensions
#'
#' Combines multiple MCMC objects (with the same parameters, chains and iterations)
#' by parameter dimensions.
#'
#' @param x An MCMC object.
#' @param x2 a second MCMC object.
#' @param along A count (or NULL) indicating the parameter dimension to bind along.
#' @param ... Unused.
#' @seealso \code{\link{bind_dimensions_n}}
#' @export
#' @examples
#' bind_dimensions(mcmcr_example, mcmcr_example)
bind_dimensions <- function(x, x2, along = NULL, ...) {
  UseMethod("bind_dimensions")
}

#' @describeIn bind_dimensions Binds two mcmcarray objects by their dimensions
#' @export
bind_dimensions.mcmcarray <- function(x, x2, along = NULL, ...) {
  if (!is.mcmcarray(x)) error("x2 must be an mcmcarray")
  checkor(check_null(along), check_count(along))

  if (!identical(nchains(x), nchains(x2)))
    error("x and x2 must have the same number of chains")

  if (!identical(niters(x), niters(x2)))
    error("x and x2 must have the same number of iterations")

  if (is.null(along)) along <- max(ndims(x), ndims(x2)) - 1

  x <- abind::abind(x, x2, along = along + 2)
  set_class(x, "mcmcarray")
}

#' @describeIn bind_dimensions Binds two mcmcr objects by their dimensions
#' @export
bind_dimensions.mcmcr <- function(x, x2, along = NULL, ...) {
  if (!is.mcmcr(x2)) error("x2 must be an mcmcr")
  checkor(check_null(along),
          check_vector(along, 1L, length = 1),
          check_vector(along, 1L, length = npars(x)))

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(parameters(x), parameters(x2)))
    error("x and x2 must have the same parameters")

  if (!identical(nchains(x), nchains(x2)))
    error("x and x2 must have the same number of chains")

  if (!identical(niters(x), niters(x2)))
    error("x and x2 must have the same number of iterations")

  if (is.null(along)) {
    along <- mapply(x, x2, FUN = function(x, x2) {max(ndims(x), ndims(x2)) - 1L}, SIMPLIFY = FALSE)
  } else if (length(along)  == 1)
    along <- rep(along, length(x))

  x <- mapply(x = x, x2 = x2, along = along, FUN = bind_dimensions, SIMPLIFY = FALSE)
  set_class(x, "mcmcr")
}
