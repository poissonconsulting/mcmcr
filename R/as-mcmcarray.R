#' Coerce to an mcmcarray object
#'
#' Coerces MCMC objects to an \code{\link{mcmcarray-object}}.
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
#' @examples
#' as.mcmcarray(as.mcarray(mcmcr_example$beta))
as.mcmcarray <- function(x, ...) UseMethod("as.mcmcarray")

#' @export
as.mcmcarray.default <- function(x, ...) {
   dim(x) <- c(1,1,dims(x))
   set_class(x, "mcmcarray")
}

#' @export
as.mcmcarray.mcarray <- function(x, ...) {
  dim(x) <- unname(dim(x))
  n <- ndims(x)
  x <- aperm(x, c(n, n - 1, 1:(n - 2)))
  set_class(x, "mcmcarray")
}

#' @export
as.mcmcarray.mcmcarray <- function(x, ...) x

#' @export
as.mcmcarray.mcmc <- function(x, ...) {
  if(npars(x) != 1) abort_chk("`x` must only have 1 parameter")

  x <- complete_terms(x)
  x <- array(data = as.vector(x), dim = c(1, niters(x), pdims(x)[[1]]))

  set_class(x, "mcmcarray")
}

#' @method as.mcmcarray mcmc.list
#' @export
as.mcmcarray.mcmc.list <- function(x, ...) as.mcmcarray(as.mcmcr(x))

#' @export
as.mcmcarray.mcmcr <- function(x, ...) {
  if(npars(x) != 1) abort_chk("`x` must only have 1 parameter")
  x[[1]]
}
