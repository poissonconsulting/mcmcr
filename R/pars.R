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
`pars<-.mcmc` <- function(x, value) {
  term <- set_pars(as.term(x), value)
  colnames(x) <- as.character(term)
  x
}

#' @export
`pars<-.mcmc.list` <- function(x, value) {
  x <- lapply(x, set_pars, pars = value)
  class(x) <- "mcmc.list"
  x
}

#' @export
`pars<-.mcmcr` <- function(x, value) {
  chk_s3_class(value, "character")
  chk_identical(length(value), length(x))
  chk_unique(value)
  names(x) <- value
  x
}

#' @export
`pars<-.mcmcrs` <- function(x, value) {
  x <- lapply(x, `pars<-`, value)
  class(x) <- "mcmcrs"
  x
}
