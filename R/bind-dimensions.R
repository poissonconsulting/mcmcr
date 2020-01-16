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

#' @export
bind_dimensions.mcmcarray <- function(x, x2, along = NULL, ...) {
  if (!is.mcmcarray(x)) err("x2 must be an mcmcarray")
  chkor(chk_null(along), chk_whole_number(along))

  if (!identical(nchains(x), nchains(x2)))
    err("x and x2 must have the same number of chains")

  if (!identical(niters(x), niters(x2)))
    err("x and x2 must have the same number of iterations")

  if (is.null(along)) along <- max(ndims(x), ndims(x2)) - 1

  x <- abind(x, x2, along = along + 2, dimnames = FALSE)
  set_class(x, "mcmcarray")
}

#' @export
bind_dimensions.mcmcr <- function(x, x2, along = NULL, ...) {
  chk_s3_class(x, "mcmcr")
  if(!is.null(along)) {
    chk_whole_numeric(along)
    chk_subset(length(along), c(1, npars(x)))
  }

  x <- sort(x)
  x2 <- sort(x2)

  if (!identical(pars(x), pars(x2)))
    err("x and x2 must have the same parameters")

  if (!identical(nchains(x), nchains(x2)))
    err("x and x2 must have the same number of chains")

  if (!identical(niters(x), niters(x2)))
    err("x and x2 must have the same number of iterations")

  if (is.null(along)) {
    along <- mapply(x, x2, FUN = function(x, x2) {max(ndims(x), ndims(x2)) - 1L}, SIMPLIFY = FALSE)
  } else if (length(along)  == 1)
    along <- rep(along, length(x))

  x <- mapply(x = x, x2 = x2, along = along, FUN = bind_dimensions, SIMPLIFY = FALSE)
  set_class(x, "mcmcr")
}
