#' Combines objects by iterations.
#'
#' Combines two or more mcmc objects by iterations
#'
#' @param x an mcmc object.
#' @param x2 a second mcmc object.
#' @param ... Unused.
#' @export
bind_iterations <- function(x, x2, ...) {
  UseMethod("bind_iterations", x)
}

#' @export
bind_iterations.mcmcarray <- function(x, x2, ...) {
  check_unused(...)
  if (!is.mcmcarray(x)) error("x2 must be an mcmcarray")

  dim <- dim(x)
  dim2 <- dim(x2)

  if (!identical(dim[-2], dim2[-2]))
    error("x and x2 must have the same dimensions (excluding iterations)")

  x %<>% abind::abind(x2, along = 2)
  class(x) <- "mcmcarray"
  x
}

#' @export
bind_iterations.mcmcr <- function(x, x2, ...) {
  check_unused(...)
  if (!is.mcmcr(x)) error("x2 must be an mcmcr")

  if (!identical(names(x), names(x2))) error("x and x2 must have the same names")

  x %<>% purrr::map2(x2, bind_iterations)
  class(x) <- "mcmcr"
  x
}
