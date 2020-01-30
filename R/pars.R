#' @export
universals::pars

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmc <- function(x, scalar = NA, terms = FALSE, ...) {
  chk_flag(terms)
  chk_unused(...)
  if(vld_true(terms)) return(pars_terms(as.term(x), scalar = scalar))
  pars(as.term(x), scalar = scalar)
}

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmc.list <- function(x, scalar = NA, terms = FALSE, ...) {
  chk_unused(...)
  pars(x[[1]], scalar = scalar, terms = terms)
}

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmcr <- function(x, scalar = NA, terms = FALSE, ...) {
  chk_unused(...)
  chk_lgl(scalar)
  chk_flag(terms)
  if(is.na(scalar) && !terms) return(names(x))
  if(terms) return(pars_terms(as.term(x), scalar = scalar))
  pars(as.term(x), scalar = scalar)
}

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmcrs <- function(x, scalar = NA, terms = FALSE, ...) {
  chk_unused(...)
  pars(x[[1]], scalar = scalar, terms = terms)
}
