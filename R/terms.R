#' @export
terms.mcmc <- function(x, ...) {
  deprecate_soft("0.2.1", "terms()", "as_term()", id = "terms")
  as_term(x)
}

#' @export
terms.mcmc.list <- function(x, ...) {
  deprecate_soft("0.2.1", "terms()", "as_term()", id = "terms")
  as_term(x)
}

#' @export
terms.mcmcarray <- function(x, ...) {
  deprecate_soft("0.2.1", "terms()", "as_term()", id = "terms")
  as_term(x)
}

#' @export
terms.mcmcr <- function(x, ...) {
  deprecate_soft("0.2.1", "terms()", "as_term()", id = "terms")
  as_term(x)
}
