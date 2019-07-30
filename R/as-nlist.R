#' @export
as.nlist.mcmc <- function(x, ...) {
  as.nlist(as.mcmcr(x))
}

#' @export
as.nlist.mcmc.list <- function(x, ...) {
  as.nlist(as.mcmcr(x))
}

#' @export
as.nlist.mcmcr <- function(x, ...) {
  if(!identical(nchains(x), 1L)) err("x must only have 1 chain")
  if(!identical(niters(x), 1L)) err("x must only have 1 iteration")

  x <- as.nlists(x)
  x[[1]]
}
