#' @export
pdims.mcarray <- function(x, ...) dims(x)[1:(length(dims(x))-2)]

#' @export
pdims.mcmc <- function(x, ...) pdims(as.term(x))

#' @export
pdims.mcmc.list <- function(x, ...) pdims(x[[1]])

#' @export
pdims.mcmcarray <- function(x, ...) dims(x)[-(1:2)]

#' @export
pdims.mcmcr <- function(x, ...) lapply(x, pdims)
