#' Subset mcmc object
#'
#' @param x The object to subset
#' @param chains An integer vector of the chains to subset by.
#' @param iterations An integer vector of the iterations to subset by.
#' @param ... Unused.
#' @export
subset.mcmcarray <- function(x, chains = NULL, iterations = NULL, ...) {


  if (!is.null(chains)) check_vector(chains, 1:nchains(x))
  if (!is.null(iterations)) check_vector(iterations, 1:niters(x))

  if (!is.null(chains)) x %<>% abind::asub(chains, 1L, drop = FALSE)
  if (!is.null(iterations)) x %<>% abind::asub(iterations, 2L, drop = FALSE)
  class(x) <- "mcmcarray"

  x
}

#' Subset mcmc object
#'
#' @param x The object to subset
#' @param chains An integer vector of the chains to subset by.
#' @param iterations An integer vector of the iterations to subset by.
#' @param parameters A character vector of  the parameters to subset by.
#' @param ... Unused.
#' @export
subset.mcmcr <- function(x, chains = NULL, iterations = NULL, parameters = NULL, ...) {

  if (!is.null(parameters)) {
    if (!all(parameters %in% parameters(x))) error("parameters must all be in x")
    if (anyDuplicated(parameters)) error("parameters must be unique")
    x <- x[parameters]
  }

  x %<>% llply(subset, chains = chains, iterations = iterations)
  class(x) <- "mcmcr"
  x
}
