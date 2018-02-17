#' Combine objects by chains.
#'
#' Combines two mcmc objects by chains.
#'
#' @param x an mcmc object.
#' @param x2 A second mcmc object
#' @param ... Unused.
#' @export
bind_chains <- function(x, x2, ...) UseMethod("bind_chains")

#' @export
bind_chains.mcarray <- function(x, x2, ...) {
  if (!is.mcmcarray(x2)) error("x2 must be an mcarray")

  dim <- dim(x)
  dim2 <- dim(x2)

  if (!identical(dim[-length(dim)], dim2[-length(dim2)]))
    error("x and x2 must have the same dimensions (excluding chains)")

  x <- abind::abind(x, x2, along = length(dim))
  class(x) <- "mcarray"
  x
}

#' @export
bind_chains.mcmc <- function(x, x2, ...) {
  if (!is.mcmc(x2)) error("x2 must be an mcmc")
  .NotYetImplemented()
  x
}

#' @export
bind_chains.mcmc.list <- function(x, x2, ...) {
  if (!is.mcmc.list(x2)) error("x2 must be an mcmc.list")
  .NotYetImplemented()
  x
}

#' @export
bind_chains.mcmcarray <- function(x, x2, ...) {
  if (!is.mcmcarray(x2)) error("x2 must be an mcmcarray")

  dim <- dim(x)
  dim2 <- dim(x2)

  if (!identical(dim[-1], dim2[-1]))
    error("x and x2 must have the same dimensions (excluding chains)")

  x <- abind::abind(x, x2, along = 1)
  class(x) <- "mcmcarray"
  x
}

#' @export
bind_chains.mcmcr <- function(x, x2, ...) {

  if (!is.mcmcr(x)) error("x2 must be an mcmcr")

  if (!identical(names(x), names(x2))) error("x and x2 must have the same names")

  x <- purrr::map2(x, x2, bind_chains)
  class(x) <- "mcmcr"
  x
}
