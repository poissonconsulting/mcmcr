#' @export
universals::pdims

#' @inherit universals::pdims
#' @export
pdims.mcarray <- function(x, ...) dims(x)[1:(length(dims(x)) - 2)]

#' @inherit universals::pdims
#' @export
pdims.mcmcarray <- function(x, ...) dims(x)[-(1:2)]

#' @inherit universals::pdims
#' @export
pdims.mcmcr <- function(x, ...) lapply(x, pdims)
