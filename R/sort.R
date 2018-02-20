#' @export
sort.mcmc <- function(x, ...) {
  terms <- terms(x)
  x <- x[,order(terms),drop = FALSE]
  class(x) <- "mcmc"
  x
}

#' @export
sort.mcmc.list <- function(x, ...) {
  x <- lapply(x, sort)
  class(x) <- "mcmc.list"
  x
}

#' @export
sort.mcmcr <- function(x, ...) {
  subset(x, parameters = sort(parameters(x)))
}
