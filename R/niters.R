#' @export
universals::niters

niters.matrix <- function(x, ...) ncol(x)

#' @inherit universals::niters
#' @export
niters.mcarray <- function(x, ...) unname(dim(x)[ndims(x) - 1])

#' @inherit universals::niters
#' @export
niters.mcmc <- function(x, ...) nrow(x)

#' @inherit universals::niters
#' @export
niters.mcmc.list <- function(x, ...) niters(x[[1]])

#' @inherit universals::niters
#' @export
niters.mcmcarray <- function(x, ...) dim(x)[2]

#' @inherit universals::niters
#' @export
niters.mcmcr <- function(x, ...) niters(x[[1]])

#' @inherit universals::niters
#' @export
niters.mcmcrs <- function(x, ...) niters(x[[1]])
