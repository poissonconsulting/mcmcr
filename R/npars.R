#' @export
universals::npars

#' @inherit universals::npars
#' @export
npars.mcmc <- function(x, ...) npars(as.term(x))

#' @inherit universals::npars
#' @export
npars.mcmc.list <- function(x, ...) npars(x[[1]])

#' @inherit universals::npars
#' @export
npars.mcarray <- function(x, ...) 1L

#' @inherit universals::npars
#' @export
npars.mcmcarray <- function(x, ...) 1L

#' @inherit universals::npars
#' @export
npars.mcmcr <- function(x, ...) length(x)

#' @inherit universals::npars
#' @export
npars.mcmcrs <- function(x, ...) npars(x[[1]])
