#' @export
universals::pars

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmc <- function(x, scalar = NA, terms = FALSE, ...) {
  chk_unused(...)
  pars(as.term(x), scalar = scalar, terms = terms)
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
  if(is.na(scalar) && !terms) return(names(x))
  pars(as.term(x), scalar = scalar, terms = terms)
}

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmcrs <- function(x, scalar = NA, terms = FALSE, ...) {
  chk_unused(...)
  pars(x[[1]], scalar = scalar, terms = terms)
}
