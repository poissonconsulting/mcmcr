#' @export
nlist::as_nlist

#' @inherit nlist::as_nlist
#' @export
as_nlist.mcmcr <- function(x, ...) {
  chk_identical(nchains(x), 1L)
  chk_identical(niters(x), 1L)

  x <- as_nlists(x)
  x[[1]]
}
