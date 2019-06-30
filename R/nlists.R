subset_mcmcarray_iteration <- function(x, iteration) {
  x <- abind::asub(x, iteration, 2L, drop = FALSE)
  dim <- dim(x)[-c(1,2)]
  if(length(dim) == 1) dim <- NULL
  dim(x) <- dim
  x
}

subset_iteration_mcmcr <- function(iteration, x) {
  lapply(x, subset_mcmcarray_iteration, iteration = iteration)
}

bind_iterations_mcmcarrays <- function(x) {
  x <- lapply(x, unclass)
  niters <- length(x)
  dim <- dims(x[[1]])
  dim <- c(dim, niters, 1L)
  x <- do.call("c", x)
  dim(x) <- dim
  x <- set_class(x, "mcarray")
  as.mcmcarray(x)
}

#' @export
as.nlists.mcmcr <- function(x, ...) {
  x <- collapse_chains(x)
  x <- lapply(1:niters(x), FUN = subset_iteration_mcmcr, x)
  x <- lapply(x, set_class, "nlist")
  set_class(x, "nlists")
}

#' @export
as.nlists.mcmc.list <- function(x, ...) {
  as.nlists(as.mcmcr(x))
}

#' @export
as.nlists.mcmc <- function(x, ...) {
  as.nlists(as.mcmcr(x))
}

#' @export
as.mcmcr.nlists <- function(x, ...) {
  x <- purrr::transpose(x)
  x <- lapply(x, bind_iterations_mcmcarrays)
  set_class(x, "mcmcr")
}

#' @export
as.mcmc.nlists <- function(x, ...) {
  as.mcmc(as.mcmcr(x))
}

#' @export
as.mcmc.list.nlists <- function(x, ...) {
  as.mcmc.list(as.mcmcr(x))
}
