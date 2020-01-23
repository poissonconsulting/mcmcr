#' @export
universals::nterms

#' @inherit universals::nterms
#' @export
nterms.mcmc <- function(x, ...) ncol(x)

#' @inherit universals::nterms
#' @export
nterms.mcmc.list <- function(x, ...) nterms(x[[1]])

#' @inherit universals::nterms
#' @export
nterms.mcmcarray <- function(x, ...) as.integer(prod(dim(x)[-(1:2)]))

#' @inherit universals::nterms
#' @export
nterms.mcmcr <- function(x, ...) sum(vapply(x, nterms, 1L))

#' @inherit universals::nterms
#' @export
nterms.mcmcrs <- function(x, ...) nterms(x[[1]])
