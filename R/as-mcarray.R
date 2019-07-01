#' Coerce to an mcarray object
#'
#' Coerces MCMC objects to an mcarray object.
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
#' @examples
#' as.mcarray(mcmcr_example$beta)
as.mcarray <- function(x, ...) UseMethod("as.mcarray")

#' @export
as.mcarray.default <- function(x, ...) as.mcarray(as.mcmcarray(x))

#' @export
as.mcarray.mcarray <- function(x, ...) x

#' @export
as.mcarray.mcmcarray <- function(x, ...) {
  n <- ndims(x)
  names(dim(x)) <- c("chain", "iteration", rep("", n - 2))
  x <- aperm(x, c(3:n, 2, 1))
  set_class(x, "mcarray")
}

