#' @importFrom universals set_pars
#' @export
universals::set_pars

#' @importFrom universals pars<-
#' @export
universals::`pars<-`

#' @export
set_pars.character <- function(x, value, ...) {
  x <- as_term(x)
  pars(x) <- value
  as.character(x)
}

#' @inherit universals::set_pars
#' @export
set_pars.mcmc <- function(x, value, ...) {
  term <- set_pars(as_term(x), value, ...)
  colnames(x) <- as.character(term)
  x
}

#' @inherit universals::set_pars
#' @export
set_pars.mcmc.list <- function(x, value, ...) {
  x <- lapply(x, set_pars, value = value, ...)
  class(x) <- "mcmc.list"
  x
}

#' @inherit universals::set_pars
#' @export
set_pars.mcmcr <- function(x, value, ...) {
  chk_pars(value)
  chk_identical(length(value), length(x))
  names(x) <- value
  x
}

#' @inherit universals::set_pars
#' @export
set_pars.mcmcrs <- function(x, value, ...) {
  x <- lapply(x, `pars<-`, value, ...)
  class(x) <- "mcmcrs"
  x
}

#' Set Parameters
#'
#' Sets an object's parameter names.
#'
#' `value` must be a unique character vector of the same length as the
#' object's parameters.
#'
#' \lifecycle{soft-deprecated} for pars<-()
#'
#' @inheritParams params
#' @param value A character vector of the new parameter names.
#' @return The modified object.
#' @export
`parameters<-` <- function(x, value) {
  set_pars(x, value)
}
