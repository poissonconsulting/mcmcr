#' @importFrom universals pars
#' @export
universals::pars

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmc <- function(x, scalar = NULL, terms = FALSE, ...) {
  if(!is.null(scalar)) chk_flag(scalar)
  chk_flag(terms)
  chk_unused(...)

  if(terms) {
    deprecate_soft("0.2.1", "mcmcr::pars(terms =)", details = "If `terms = TRUE` use `terms::pars_terms(as_term(x)) otherwise replace `pars(x, terms = FALSE)` with `pars(x)`.", id = "pars_terms")
  }
  x <- as_term(x)
  pars(x, scalar = scalar, terms = terms)
}

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmc.list <- function(x, scalar = NULL, terms = FALSE, ...) {
  pars(x[[1]], scalar = scalar, terms = terms, ...)
}

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmcr <- function(x, scalar = NULL, terms = FALSE, ...) {
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

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmcrs <- function(x, scalar = NULL, terms = FALSE, ...) {
  pars(x[[1]], scalar = scalar, terms = terms, ...)
}
