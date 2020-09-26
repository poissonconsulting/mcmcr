#' @importFrom universals set_pars
#' @export
universals::set_pars

#' @importFrom universals pars<-
#' @export
universals::`pars<-`

#' @export
set_pars.character <- function(x, value, ...) {
  x <- as_term(x)
  pars(x) <- value
  as.character(x)
}

#' @inherit universals::set_pars
#' @export
set_pars.mcmcr <- function(x, value, ...) {
  chk_pars(value)
  chk_identical(length(value), length(x))
  names(x) <- value
  x
}

#' @inherit universals::set_pars
#' @export
set_pars.mcmcrs <- function(x, value, ...) {
  x <- lapply(x, `pars<-`, value, ...)
  class(x) <- "mcmcrs"
  x
}
