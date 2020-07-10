#' Parameter Names
#'
#' Gets the parameter names.
#'
#' \lifecycle{soft-deprecated} for pars()
#'
#' @inheritParams params
#' @return A character vector of the names of the parameters.
#' @export
parameters <- function(x, ...) {
  UseMethod("parameters")
}

#' @describeIn parameters Parameters mcmc
#' @export
parameters.mcmc <- function(x, scalar = NULL, terms = FALSE, ...) {
  deprecate_soft("0.2.1", "parameters()", "pars()", id = "parameters")

  if(!is.null(scalar)) chk_flag(scalar)
  chk_flag(terms)
  chk_unused(...)

  if(terms) {
    deprecate_soft("0.2.1", "mcmcr::pars(terms =)", details = "If `terms = TRUE` use `terms::pars_terms(as_term(x)) otherwise replace `pars(x, terms = FALSE)` with `pars(x)`.", id = "pars_terms")
  }
  x <- as_term(x)
  pars(x, scalar = scalar, terms = terms)
}

#' @describeIn parameters Parameters mcmc.list
#' @export
parameters.mcmc.list <- function(x, scalar = NULL, terms = FALSE, ...) {
  deprecate_soft("0.2.1", "parameters()", "pars()", id = "parameters")
  pars(x[[1]], scalar = scalar, terms = terms, ...)
}

#' @describeIn parameters Parameters mcmcr
#' @export
parameters.mcmcr <- function(x, scalar = NULL, terms = FALSE, ...) {
  deprecate_soft("0.2.1", "parameters()", "pars()", id = "parameters")
  if(!is.null(scalar)) chk_flag(scalar)
  chk_flag(terms)
  chk_unused(...)

  if(terms) {
    deprecate_soft("0.2.1", "mcmcr::pars(terms =)", details = "If `terms = TRUE` use `terms::pars_terms(as_term(x)) otherwise replace `pars(x, terms = FALSE)` with `pars(x)`.", id = "pars_terms")
  }

  if(is.null(scalar) && !terms) return(names(x))
  x <- as_term(x)
  pars(x, scalar = scalar, terms = terms)
}

#' @describeIn parameters Parameters mcmcrs
#' @export
parameters.mcmcrs <- function(x, scalar = NULL, terms = FALSE, ...) {
  deprecate_soft("0.2.1", "parameters()", "pars()", id = "parameters")
  pars(x[[1]], scalar = scalar, terms = terms, ...)
}


#' @export
`parameters<-` <- function(x, value, ...) {
  deprecate_soft("0.2.1", "parameters()", "pars()", id = "parameters")
  pars(x) <- value
  x
}
