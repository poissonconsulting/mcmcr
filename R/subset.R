#' Subset an MCMC Object
#'
#' Subsets an MCMC object by its chains, iterations and/or pars.
#'
#' @param x The MCMC object to subset
#' @param chains An integer vector (or NULL) of the chains to subset by.
#' @param iterations An integer vector (or NULL) of the iterations to subset by.
#' @param pars A character vector (or NULL) of the pars to subset by.
#' @param ... Unused
#' @name subset
#' @examples
#' subset(mcmcr_example, chains = 2L, iterations = 1:100,
#'   pars = c("beta", "alpha"))
NULL


#' @describeIn subset Subset an mcmc object
#' @export
subset.mcmc <- function(x, iterations = NULL, pars = NULL, ...) {
  checkor(check_null(iterations), check_vector(iterations, c(1L,niters(x))))
  checkor(check_null(pars),
          check_vector(pars, pars(x), unique = TRUE))
  check_unused(...)

  if (!is.null(pars)) x <- x[,pars(x, term = TRUE) %in% pars,drop = FALSE]
  if (!is.null(iterations)) x <- x[iterations,,drop = FALSE]
  class(x) <- "mcmc"
  x
}

#' @describeIn subset Subset an mcmc.list object
#' @export
subset.mcmc.list <- function(x, chains = NULL, iterations = NULL, pars = NULL, ...) {
  checkor(check_null(chains), check_vector(chains, c(1L,nchains(x))))
  check_unused(...)

  if(!is.null(chains))
    x <- x[chains]
  x <- lapply(x, subset, iterations = iterations, pars = pars)
  class(x) <- "mcmc.list"
  x
}

#' @describeIn subset Subset an mcmcarray object
#' @export
subset.mcmcarray <- function(x, chains = NULL, iterations = NULL, ...) {
  checkor(check_null(chains), check_vector(chains, c(1L,nchains(x))))
  checkor(check_null(iterations), check_vector(iterations, c(1L,niters(x))))
  check_unused(...)

  if (!is.null(chains)) x <- abind::asub(x, chains, 1L, drop = FALSE)
  if (!is.null(iterations)) x <- abind::asub(x, iterations, 2L, drop = FALSE)
  class(x) <- "mcmcarray"
  x
}

#' @describeIn subset Subset an mcmcr object
#' @export
subset.mcmcr <- function(x, chains = NULL, iterations = NULL, pars = NULL, ...) {
  checkor(check_null(pars),
          check_vector(pars, pars(x), unique = TRUE))
  check_unused(...)

  if (!is.null(pars)) x <- x[pars]

  x <- lapply(x, subset, chains = chains, iterations = iterations)
  class(x) <- "mcmcr"
  x
}

#' @describeIn subset Subset an mcmcrs object
#' @export
subset.mcmcrs <- function(x, chains = NULL, iterations = NULL, pars = NULL, ...) {
  check_unused(...)

  x <- lapply(x, FUN = subset, chains = chains, iterations = iterations, pars = pars)
  class(x) <- "mcmcrs"
  x
}
