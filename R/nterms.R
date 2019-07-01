#' @export
nterms.mcmcarray <- function(x, ...) as.integer(prod(dim(x)[-(1:2)]))

#' @export
nterms.mcmcr <- function(x, ...) sum(vapply(x, nterms, 1L))

#' @export
nterms.mcmcrs <- function(x, ...) nterms(x[[1]])
