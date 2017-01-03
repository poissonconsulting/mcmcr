#' Coerce to an mcmcr object
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @examples
#' as.mcmcr(list_mcarrays)
#' @export
as.mcmcr <- function(x, ...) {
  UseMethod("as.mcmcr", x)
}

#' Coerce to an mcmcarray object
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @examples
#' as.mcmcarray(list_mcarrays[[1]])
#' @export
as.mcmcarray <- function(x, ...) {
  UseMethod("as.mcmcarray", x)
}

#' @export
as.mcmcr.list <- function(x, ...) {
  check_unused(...)
  x %<>% lapply(as.mcmcarray)
  class(x) <- "mcmcr"
  x
}

#' @export
as.mcmcarray.mcarray <- function(x, ...) {
  check_unused(...)

  names(dim(x)) <- NULL
  n <- ndims(x)
  x %<>% aperm(c(n, n - 1, 1:(n - 2)))
  class(x) <- "mcmcarray"
  x
}
