#' @export
pars.mcmc <- function(x, scalar_only = FALSE, terms = FALSE, ...) {
  check_unused(...)
  pars(as.term(x), scalar_only = scalar_only, terms = terms)
}

#' @export
pars.mcmc.list <- function(x, scalar_only = FALSE, terms = FALSE, ...) {
  check_unused(...)
  pars(x[[1]], scalar_only = scalar_only, terms = terms)
}

#' @export
pars.mcmcr <- function(x, scalar_only = FALSE, terms = FALSE, ...) {
  check_unused(...)
  if(!scalar_only && !terms) return(names(x))
  pars(as.term(x), scalar_only = scalar_only, terms = terms)
}

#' @export
pars.mcmcrs <- function(x, scalar_only = FALSE, terms = FALSE, ...) {
  check_unused(...)
  pars(x[[1]], scalar_only = scalar_only, terms = terms)
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
  check_vector(value, "", length = length(x), unique = TRUE)
  names(x) <- value
  x
}

#' @export
`pars<-.mcmcrs` <- function(x, value) {
  x <- lapply(x, `pars<-`, value)
  class(x) <- "mcmcrs"
  x
}