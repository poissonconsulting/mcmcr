#' @export
universals::npars

#' @inherit universals::npars
#' @inheritParams params
#' @export
npars.mcarray <- function(x, scalar = NULL, ...) {
  chk_unused(...)
  if(is.null(scalar)) return(1L)
  length(pars(x, scalar = scalar))
}

#' @inherit universals::npars
#' @inheritParams params
#' @export
npars.mcmcarray <- function(x, scalar = NULL, ...) {
  chk_unused(...)
  if(is.null(scalar)) return(1L)
  length(pars(x, scalar = scalar))
}

#' @inherit universals::npars
#' @inheritParams params
#' @export
npars.mcmcr <- function(x, scalar = NULL, ...) {
  chk_unused(...)
  if(is.null(scalar)) return(length(x))
  length(pars(x, scalar = scalar))
}
