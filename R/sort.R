#' @export
sort.mcmcr <- function(x, ...) subset(x, pars = sort(pars(x)))

#' @export
sort.mcmcrs <- function(x, ...) set_class(lapply(x[order(names(x))], sort), "mcmcrs")
