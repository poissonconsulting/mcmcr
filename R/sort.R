#' Sort an MCMC Object
#'
#' Sorts an MCMC object by its parameter names.
#'
#' @param x The MCMC object to sort
#' @param ... Unused
#' @name sort
#' @examples
#' parameters(mcmcr_example)
#' mcmcr_example <- subset(mcmcr_example, parameters = c("beta", "alpha"))
#' parameters(mcmcr_example)
#' mcmcr_example <- sort(mcmcr_example)
#' parameters(mcmcr_example)
NULL

#' @describeIn sort Sort an mcmc object
#' @export
sort.mcmc <- function(x, ...) set_class(x[,order(terms(x)),drop = FALSE], "mcmc")

#' @describeIn sort Sort an mcmc.list object
#' @export
sort.mcmc.list <- function(x, ...) set_class(lapply(x, sort), "mcmc.list")

#' @describeIn sort Sort an mcmcr object
#' @export
sort.mcmcr <- function(x, ...) subset(x, parameters = sort(parameters(x)))

#' @describeIn sort Sort an mcmcrs object
#' @export
sort.mcmcrs <- function(x, ...) set_class(lapply(x[order(names(x))], sort), "mcmcrs")
