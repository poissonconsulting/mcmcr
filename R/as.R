#' Coerce to an mcarray object
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
as.mcarray <- function(x, ...) UseMethod("as.mcarray")

#' Coerce to an mcmcarray object
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
as.mcmcarray <- function(x, ...) UseMethod("as.mcmcarray")

#' Coerce to an mcmcr object
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
as.mcmcr <- function(x, ...) UseMethod("as.mcmcr")

#' Coerce to an mcmcrs object
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
as.mcmcrs <- function(x, ...) UseMethod("as.mcmcrs")

#' @export
as.mcarray.mcmcarray <- function(x, ...) {
  n <- ndims(x)
  names(dim(x)) <- c("chain", "iteration", rep("", n - 2))
  x <- aperm(x, c(3:n, 2, 1))
  class(x) <- "mcarray"
  x
}

#' @export
as.mcmc.mcmcarray <- function(x) {
  if(nchains(x) != 1) error("x must only have 1 chain")
  terms <- as.term(x)
  x <- apply(x, 1, identity)
  x <- as.matrix(x)
  colnames(x) <- as.character(terms)
  coda::as.mcmc(x)
}

#' @method as.mcmc.list mcmcarray
#' @export
as.mcmc.list.mcmcarray <- function(x, ...) {
  x <- lapply(1:nchains(x), function(chain, x) {subset(x, chains = chain)}, x = x)
  x <- lapply(x, as.mcmc)
  coda::mcmc.list(x)
}

#' @method as.mcmc.list mcmcr
#' @export
as.mcmc.list.mcmcr <- function(x, ...) {
  parameters <- parameters(x)
  x <- lapply(x, as.mcmc.list)
  x <- mapply(x, parameters, FUN = set_parameters, SIMPLIFY = FALSE)
  x <- Reduce(bind_parameters, x)
  x
}

#' @export
as.mcmcarray.default <- function(x, ...) {
  dim(x) <- c(1,1,dims(x))
  class(x) <- "mcmcarray"
  x
}

#' @export
as.mcmcarray.mcarray <- function(x, ...) {
  dim(x) <- unname(dim(x))
  n <- ndims(x)
  x <- aperm(x, c(n, n - 1, 1:(n - 2)))
  class(x) <- "mcmcarray"
  x
}

#' @export
as.mcmcr.list <- function(x, ...) {
  check_length(x)
  check_named(x, unique = TRUE)

  if (!all(vapply(x, is.mcmcarray, TRUE)))
    error("all objects must inherit from mcmcarray")

  nchains <- vapply(x, nchains, 1L)
  niters <- vapply(x, niters, 1L)

  if (!identical(length(unique(nchains)), 1L))
    error("all objects must have the same number of chains")

  if (!identical(length(unique(niters)), 1L))
    error("all objects must have the same number of iterations")

  class(x) <- "mcmcr"
  x
}

#' @export
as.mcmcr.mcmc <- function(x, ...) {
  parameters <- parameters(x)
  x <- lapply(parameters, function(p, x) subset(x, parameters = p), x = x)
  x <- lapply(x, as_mcmcarray_mcmc1)
  names(x) <- parameters
  class(x) <- "mcmcr"
  x
}

#' @export
as.mcmcr.mcmc.list <- function(x, ...) {
  x <- lapply(x, as.mcmcr)
  Reduce(bind_chains, x)
}

#' @export
as.mcmcrs.list <- function(x, ...) {
  check_length(x)
  if (!all(vapply(x, is.mcmcr, TRUE)))
    error("all objects must inherit from mcmcr")

  nchains <- vapply(x, nchains, 1L)
  niters <- vapply(x, niters, 1L)
  parameters <- lapply(x, parameters)

  if (!identical(length(unique(nchains)), 1L))
    error("all objects must have the same number of chains")

  if (!identical(length(unique(niters)), 1L))
    error("all objects must have the same number of iterations")

  if (!identical(length(unique(parameters)), 1L))
    error("all objects must have the same parameters")
  class(x) <- "mcmcrs"
  x
}
