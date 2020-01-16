#' Subset an MCMC Object
#'
#' Subsets an MCMC object by its chains, iterations and/or parameters.
#'
#' @param x The MCMC object to subset
#' @inheritParams nlist::subset.nlists
#' @name subset
#' @examples
#' subset(mcmcr_example, chains = 2L, iters = 1:100,
#'   pars = c("beta", "alpha"))
NULL


#' @describeIn subset Subset an mcmc object
#' @export
subset.mcmc <- function(x, iters = NULL, pars = NULL, ...) {
  chkor(chk_null(iters), check_vector(iters, c(1L,niters(x))))
  chkor(chk_null(pars),
          check_vector(pars, pars(x), unique = TRUE))
  chk_unused(...)

  if (!is.null(pars)) x <- x[,pars(x, term = TRUE) %in% pars,drop = FALSE]
  if (!is.null(iters)) x <- x[iters,,drop = FALSE]
  class(x) <- "mcmc"
  x
}

#' @describeIn subset Subset an mcmc.list object
#' @export
subset.mcmc.list <- function(x, chains = NULL, iters = NULL, pars = NULL, ...) {
  chkor(chk_null(chains), check_vector(chains, c(1L,nchains(x))))
  chk_unused(...)

  if(!is.null(chains))
    x <- x[chains]
  x <- lapply(x, subset, iters = iters, pars = pars)
  class(x) <- "mcmc.list"
  x
}

#' @describeIn subset Subset an mcmcarray object
#' @export
subset.mcmcarray <- function(x, chains = NULL, iters = NULL, ...) {
  chkor(chk_null(chains), check_vector(chains, c(1L,nchains(x))))
  chkor(chk_null(iters), check_vector(iters, c(1L,niters(x))))
  chk_unused(...)

  if (!is.null(chains)) x <- abind::asub(x, chains, 1L, drop = FALSE)
  if (!is.null(iters)) x <- abind::asub(x, iters, 2L, drop = FALSE)
  class(x) <- "mcmcarray"
  x
}

#' @describeIn subset Subset an mcmcr object
#' @export
subset.mcmcr <- function(x, chains = NULL, iters = NULL, pars = NULL, ...) {
  chkor(chk_null(pars),
          check_vector(pars, pars(x), unique = TRUE))
  chk_unused(...)

  if (!is.null(pars)) x <- x[pars]

  x <- lapply(x, subset, chains = chains, iters = iters)
  class(x) <- "mcmcr"
  x
}

#' @describeIn subset Subset an mcmcrs object
#' @export
subset.mcmcrs <- function(x, chains = NULL, iters = NULL, pars = NULL, ...) {
  chk_unused(...)

  x <- lapply(x, FUN = subset, chains = chains, iters = iters, pars = pars)
  class(x) <- "mcmcrs"
  x
}
