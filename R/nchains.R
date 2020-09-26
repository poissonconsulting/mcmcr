#' @export
universals::nchains

nchains.matrix <- function(x, ...) nrow(x)

#' @inherit universals::nchains
#' @export
nchains.mcarray <- function(x, ...) unname(dim(x)[ndims(x)])

#' @inherit universals::nchains
#' @export
nchains.mcmcarray <- function(x, ...) dim(x)[1]

#' @inherit universals::nchains
#' @export
nchains.mcmcr <- function(x, ...) nchains(x[[1]])

#' @inherit universals::nchains
#' @export
nchains.mcmcrs <- function(x, ...) nchains(x[[1]])
