#' Combines objects by terms
#'
#' Combines two or more mcmc objects by terms.
#'
#' @param x an mcmc object.
#' @param x2 a second mcmc object.
#' @param ... Unused.
#' @export
bind_terms <- function(x, x2, ...) {
  UseMethod("bind_terms", x)
}

#' @export
bind_terms.mcmc <- function(x, x2, ...) {
  

  if (!identical(coda::niter(x), coda::niter(x2)))
    error("x and x2 must have the same number of iterations")

  x %<>% abind::abind(x2, along = 2)

  coda::as.mcmc(x)
}

#' @export
bind_terms.mcmc.list <- function(x, x2, ...) {
  
  if (!coda::is.mcmc.list(x)) error("x2 must be an mcmc.list")

  if (!identical(coda::nchain(x), coda::nchain(x2)))
    error("x and x2 must have the same number of chains")

  x %<>% purrr::map2(x2, bind_terms)
  class(x) <- "mcmc.list"
  x
}
