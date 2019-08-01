#' @export
npars.mcmc <- function(x, ...) npars(as.term(x))

#' @export
npars.mcmc.list <- function(x, ...) npars(x[[1]])

#' @export
npars.mcarray <- function(x, ...) 1L

#' @export
npars.mcmcarray <- function(x, ...) 1L

#' @export
npars.mcmcr <- function(x, ...) length(x)

#' @export
npars.mcmcrs <- function(x, ...) npars(x[[1]])
