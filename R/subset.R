#' Subset an MCMC Object
#'
#' Subsets an MCMC object by its chains, iterations and/or parameters.
#'
#' @param x The MCMC object to subset
#' @inheritParams nlist::subset.nlists
#' @inheritParams params
#' @name subset
#' @examples
#' subset(mcmcr_example, chains = 2L, iters = 1:100,
#'   pars = c("beta", "alpha"))
NULL


#' @describeIn subset Subset an mcmc object
#' @export
subset.mcmc <- function(x, iters = NULL, pars = NULL,
                        iterations = NULL, parameters = NULL, ...) {
  if(!missing(iterations)) {
    deprecate_soft("0.2.1", "subset(iterations = )", "subset(iters = )",
                   id = "subset_iterations")
    iters <- iterations
  }
  if(!missing(parameters)) {
    deprecate_soft("0.2.1", "subset(parameters = )", "subset(pars = )",
                   id = "subset_parameters")
    pars <- parameters
  }
  if(!is.null(iters)) {
    chk_whole_numeric(iters)
    chk_range(iters, c(1L, niters(x)))
  }
  if(!is.null(pars)) {
    chk_s3_class(pars, "character")
    chk_not_any_na(pars)
    chk_unique(pars)
    chk_subset(pars, pars(x))
  }
  chk_unused(...)

  if (!is.null(pars)) x <- x[,pars_terms(as_term(x)) %in% pars,drop = FALSE]
  if (!is.null(iters)) x <- x[iters,,drop = FALSE]
  class(x) <- "mcmc"
  x
}

#' @describeIn subset Subset an mcmc.list object
#' @export
subset.mcmc.list <- function(x, chains = NULL, iters = NULL, pars = NULL,
                             iterations = NULL, parameters = NULL, ...) {
  if(!missing(iterations)) {
    deprecate_soft("0.2.1", "subset(iterations = )", "subset(iters = )",
                   id = "subset_iterations")
    iters <- iterations
  }
  if(!missing(parameters)) {
    deprecate_soft("0.2.1", "subset(parameters = )", "subset(pars = )",
                   id = "subset_parameters")
    pars <- parameters
  }
  if(!is.null(chains)) {
    chk_whole_numeric(chains)
    chk_not_any_na(chains)
    chk_range(chains, c(1L, nchains(x)))
  }
  chk_unused(...)

  if(!is.null(chains))
    x <- x[chains]
  x <- lapply(x, subset, iters = iters, pars = pars)
  class(x) <- "mcmc.list"
  x
}

#' @describeIn subset Subset an mcmcarray object
#' @export
subset.mcmcarray <- function(x, chains = NULL, iters = NULL,
                             iterations = NULL, ...) {
  if(!missing(iterations)) {
    deprecate_soft("0.2.1", "subset(iterations = )", "subset(iters = )",
                   id = "subset_iterations")
    iters <- iterations
  }
  if(!is.null(chains)) {
    chk_whole_numeric(chains)
    chk_not_any_na(chains)
    chk_range(chains, c(1L, nchains(x)))
  }
  if(!is.null(iters)) {
    chk_whole_numeric(iters)
    chk_not_any_na(iters)
    chk_range(iters, c(1L, niters(x)))
  }
  chk_unused(...)

  if (!is.null(chains)) x <- abind::asub(x, chains, 1L, drop = FALSE)
  if (!is.null(iters)) x <- abind::asub(x, iters, 2L, drop = FALSE)
  class(x) <- "mcmcarray"
  x
}

#' @describeIn subset Subset an mcmcr object
#' @export
subset.mcmcr <- function(x, chains = NULL, iters = NULL, pars = NULL,
                         iterations = NULL, parameters = NULL, ...) {
  if(!missing(iterations)) {
    deprecate_soft("0.2.1", "subset(iterations = )", "subset(iters = )",
                   id = "subset_iterations")
    iters <- iterations
  }
  if(!missing(parameters)) {
    deprecate_soft("0.2.1", "subset(parameters = )", "subset(pars = )",
                   id = "subset_parameters")
    pars <- parameters
  }
  if(!is.null(pars)) {
    chk_s3_class(pars, "character")
    chk_subset(pars, pars(x))
    chk_unique(pars)
  }
  chk_unused(...)

  if (!is.null(pars)) x <- x[pars]

  x <- lapply(x, subset, chains = chains, iters = iters)
  class(x) <- "mcmcr"
  x
}

#' @describeIn subset Subset an mcmcrs object
#' @export
subset.mcmcrs <- function(x, chains = NULL, iters = NULL, pars = NULL,
                          iterations = NULL, parameters = NULL, ...) {
  if(!missing(iterations)) {
    deprecate_soft("0.2.1", "subset(iterations = )", "subset(iters = )",
                   id = "subset_iterations")
    iters <- iterations
  }
  if(!missing(parameters)) {
    deprecate_soft("0.2.1", "subset(parameters = )", "subset(pars = )",
                   id = "subset_parameters")
    pars <- parameters
  }
  chk_unused(...)

  x <- lapply(x, FUN = subset, chains = chains, iters = iters, pars = pars)
  class(x) <- "mcmcrs"
  x
}
