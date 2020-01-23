#' @export
pars.mcmc <- function(x, scalar = NA, terms = FALSE, ...) {
  chk_unused(...)
  pars(as.term(x), scalar = scalar, terms = terms)
}

#' @export
pars.mcmc.list <- function(x, scalar = NA, terms = FALSE, ...) {
  chk_unused(...)
  pars(x[[1]], scalar = scalar, terms = terms)
}

#' @export
pars.mcmcr <- function(x, scalar = NA, terms = FALSE, ...) {
  chk_unused(...)
  if(is.na(scalar) && !terms) return(names(x))
  pars(as.term(x), scalar = scalar, terms = terms)
}

#' @export
pars.mcmcrs <- function(x, scalar = NA, terms = FALSE, ...) {
  chk_unused(...)
  pars(x[[1]], scalar = scalar, terms = terms)
}

#' @export
set_pars.mcmc <- function(x, value, ...) {
  chk_unused(...)
  term <- set_pars(as.term(x), value)
  colnames(x) <- as.character(term)
  x
}

#' @export
set_pars.mcmc.list <- function(x, value, ...) {
  chk_unused(...)
  x <- lapply(x, set_pars, value = value)
  class(x) <- "mcmc.list"
  x
}

#' @export
set_pars.mcmcr <- function(x, value, ...) {
  chk_s3_class(value, "character")
  chk_identical(length(value), length(x))
  chk_unique(value)
  chk_unused(...)
  names(x) <- value
  x
}

#' @export
set_pars.mcmcrs <- function(x, value, ...) {
  chk_unused(...)
  x <- lapply(x, `pars<-`, value)
  class(x) <- "mcmcrs"
  x
}
