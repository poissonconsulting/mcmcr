#' @export
nlist::as.nlist

#' @inherit nlist::as.nlist
#' @export
as.nlist.mcmc <- function(x, ...) {
  as.nlist(as.mcmcr(x))
}

#' @inherit nlist::as.nlist
#' @export
as.nlist.mcmc.list <- function(x, ...) {
  as.nlist(as.mcmcr(x))
}

#' @inherit nlist::as.nlist
#' @export
as.nlist.mcmcr <- function(x, ...) {
  chk_identical(nchains(x), 1L)
  chk_identical(niters(x), 1L)

  x <- as.nlists(x)
  x[[1]]
}
