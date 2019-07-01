#' @export
npars.mcarray <- function(x, ...) 1L

#' @export
npars.mcmcarray <- function(x, ...) 1L

#' @export
npars.mcmcr <- function(x, ...) length(x)

#' @export
npars.mcmcrs <- function(x, ...) npars(x[[1]])
