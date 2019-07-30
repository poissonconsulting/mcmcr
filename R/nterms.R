#' @export
nterms.mcmc <- function(x, ...) ncol(x)

#' @export
nterms.mcmc.list <- function(x, ...) nterms(x[[1]])

#' @export
nterms.mcmcarray <- function(x, ...) as.integer(prod(dim(x)[-(1:2)]))

#' @export
nterms.mcmcr <- function(x, ...) sum(vapply(x, nterms, 1L))

#' @export
nterms.mcmcrs <- function(x, ...) nterms(x[[1]])
