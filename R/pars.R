#' @export
universals::pars

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmc <- function(x, scalar = NA, terms = FALSE, ...) {

  x <- as.term(x)

  chk_lgl(scalar)
  chk_flag(terms)
  chk_unused(...)

  if(!missing(terms)) {
    deprecate_soft("0.2.1", "mcmcr::pars(terms =)", details = "If `terms = TRUE` use `terms::pars_terms(as.term(x)) otherwise replace `pars(x, terms = FALSE)` with `pars(x)`.", id = "pars_terms")
  }
  if(!missing(scalar)) {
    deprecate_soft("0.2.1", "mcmcr::pars(scalar =)", details = "If `terms = TRUE` use `pars_scalar()'.", id = "pars_scalar")
  }

  stopifnot(!vld_false(scalar))
  stopifnot(!terms || is.na(scalar))

  if(vld_true(terms)) return(pars_terms(x))
  if(vld_true(scalar)) return(pars_scalar(x))
  pars(x)
}

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmc.list <- function(x, scalar = NA, terms = FALSE, ...) {

  x <- x[[1]]
  chk_lgl(scalar)
  chk_flag(terms)
  chk_unused(...)

  if(!missing(terms)) {
    deprecate_soft("0.2.1", "mcmcr::pars(terms =)", details = "If `terms = TRUE` use `terms::pars_terms(as.term(x)) otherwise replace `pars(x, terms = FALSE)` with `pars(x)`.", id = "pars_terms")
  }
  if(!missing(scalar)) {
    deprecate_soft("0.2.1", "mcmcr::pars(scalar =)", details = "If `terms = TRUE` use `pars_scalar()'.", id = "pars_scalar")
  }

  stopifnot(!vld_false(scalar))
  stopifnot(!terms || is.na(scalar))

  if(vld_true(terms)) return(pars_terms(x))
  if(vld_true(scalar)) return(pars_scalar(x))
  pars(x)
}

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmcr <- function(x, scalar = NA, terms = FALSE, ...) {

  chk_lgl(scalar)
  chk_flag(terms)
  chk_unused(...)

  if(!missing(terms)) {
    deprecate_soft("0.2.1", "mcmcr::pars(terms =)", details = "If `terms = TRUE` use `terms::pars_terms(as.term(x)) otherwise replace `pars(x, terms = FALSE)` with `pars(x)`.", id = "pars_terms")
  }
  if(!missing(scalar)) {
    deprecate_soft("0.2.1", "mcmcr::pars(scalar =)", details = "If `terms = TRUE` use `pars_scalar()'.", id = "pars_scalar")
  }

  stopifnot(!vld_false(scalar))
  stopifnot(!terms || is.na(scalar))

  if(is.na(scalar) && !terms) return(names(x))
  x <- as.term(x)
  if(terms) return(pars_terms(x))
  if(vld_true(scalar)) return(pars_scalar(x))
  pars(x)
}

#' @inherit universals::pars
#' @inheritParams params
#' @export
pars.mcmcrs <- function(x, scalar = NA, terms = FALSE, ...) {

  x <- x[[1]]

  chk_lgl(scalar)
  chk_flag(terms)
  chk_unused(...)

  if(!missing(terms)) {
    deprecate_soft("0.2.1", "mcmcr::pars(terms =)", details = "If `terms = TRUE` use `terms::pars_terms(as.term(x)) otherwise replace `pars(x, terms = FALSE)` with `pars(x)`.", id = "pars_terms")
  }
  if(!missing(scalar)) {
    deprecate_soft("0.2.1", "mcmcr::pars(scalar =)", details = "If `terms = TRUE` use `pars_scalar()'.", id = "pars_scalar")
  }

  stopifnot(!vld_false(scalar))
  stopifnot(!terms || is.na(scalar))

  if(vld_true(terms)) return(pars_terms(x))
  if(vld_true(scalar)) return(pars_scalar(x))
  pars(x)
}
