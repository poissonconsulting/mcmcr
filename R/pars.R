#' @importFrom universals pars
#' @export
universals::pars

pars_impl <- function(x, scalar, terms) {
  if (is.null(scalar) && !terms) {
    return(names(x))
  }
  x <- as_term(x)
  if (isTRUE(terms))
    return(pars_terms(x))

  pars(as_term_rcrd(x), scalar = scalar)
}

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmcr <- function(x, scalar = NULL, terms = FALSE, ...) {
  if (!is.null(scalar)) chk_flag(scalar)
  chk_flag(terms)
  chk_unused(...)

  if (!missing(terms)) {
    deprecate_soft("0.2.1", "mcmcr::pars(terms =)", details = "If `terms = TRUE` use `terms::pars_terms(as_term(x)) otherwise replace `pars(x, terms = FALSE)` with `pars(x)...`.", id = "pars_terms")
  }
  pars_impl(x, scalar, terms)
}

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmcrs <- function(x, scalar = NULL, terms = FALSE, ...) {
  if (!is.null(scalar)) chk_flag(scalar)
  chk_flag(terms)
  chk_unused(...)

  if (!missing(terms)) {
    deprecate_soft("0.2.1", "mcmcr::pars(terms =)", details = "If `terms = TRUE` use `terms::pars_terms(as_term(x)) otherwise replace `pars(x, terms = FALSE)` with `pars(x)`.", id = "pars_terms")
  }
  pars_impl(x[[1]], scalar = scalar, terms = terms, ...)
}
