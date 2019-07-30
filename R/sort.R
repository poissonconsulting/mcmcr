#' @export
sort.mcmc <- function(x, ...) set_class(x[,order(as.term(x)),drop = FALSE], "mcmc")

#' @export
sort.mcmc.list <- function(x, ...) set_class(lapply(x, sort), "mcmc.list")

#' @export
sort.mcmcr <- function(x, ...) subset(x, parameters = sort(pars(x)))

#' @export
sort.mcmcrs <- function(x, ...) set_class(lapply(x[order(names(x))], sort), "mcmcrs")
