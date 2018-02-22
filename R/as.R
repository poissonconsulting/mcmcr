#' Coerce to an mcarray object
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
#' @examples
#' as.mcarray(mcmcr_example$beta)
as.mcarray <- function(x, ...) UseMethod("as.mcarray")

#' Coerce to an mcmcarray object
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
#' @examples
#' as.mcmcarray(as.mcarray(mcmcr_example$beta))
as.mcmcarray <- function(x, ...) UseMethod("as.mcmcarray")

#' Coerce to an mcmcr object
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
#' @examples
#' as.mcmcr(coda::as.mcmc.list(mcmcr_example))
as.mcmcr <- function(x, ...) UseMethod("as.mcmcr")

#' Coerce to an mcmcrs object
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
#' @examples
#' as.mcmcrs(list(mcmcr_example))
as.mcmcrs <- function(x, ...) UseMethod("as.mcmcrs")

#' @export
as.mcarray.default <- function(x, ...) as.mcarray(as.mcmcarray(x))

#' @export
as.mcarray.mcarray <- function(x, ...) x

#' @export
as.mcarray.mcmcarray <- function(x, ...) {
  n <- ndims(x)
  names(dim(x)) <- c("chain", "iteration", rep("", n - 2))
  x <- aperm(x, c(3:n, 2, 1))
  set_class(x, "mcarray")
}

#' @export
as.mcmc.mcarray <- function(x) as.mcmc(as.mcmcarray(x))

#' @export
as.mcmc.mcmcarray <- function(x) {
  if(nchains(x) != 1) error("x must only have 1 chain")
  terms <- terms(x)
  x <- apply(x, 1, identity)
  x <- matrix(x, ncol = length(terms))
  colnames(x) <- as.character(terms)
  coda::as.mcmc(x)
}

#' @export
as.mcmc.mcmc <- function(x, ...) x

#' @method as.mcmc mcmc.list
#' @export
as.mcmc.mcmc.list <- function(x) {
  if(nchains(x) != 1) error("x must only have 1 chain")
  x[[1]]
}

#' @export
as.mcmc.mcmcr <- function(x) as.mcmc(as.mcmc.list(x))

#' @method as.mcmc.list mcarray
#' @export
as.mcmc.list.mcarray <- function(x) as.mcmc.list(as.mcmcarray(x))

#' @method as.mcmc.list mcmcarray
#' @export
as.mcmc.list.mcmcarray <- function(x, ...) {
  x <- lapply(1:nchains(x), function(chain, x) {subset(x, chains = chain)}, x = x)
  x <- lapply(x, as.mcmc)
  coda::mcmc.list(x)
}

#' @method as.mcmc.list mcmc
#' @export
as.mcmc.list.mcmc <- function(x, ...) set_class(list(x), "mcmc.list")

#' @method as.mcmc.list mcmc.list
#' @export
as.mcmc.list.mcmc.list <- function(x, ...) x

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
   set_class(x, "mcmcarray")
}

#' @export
as.mcmcarray.mcarray <- function(x, ...) {
  dim(x) <- unname(dim(x))
  n <- ndims(x)
  x <- aperm(x, c(n, n - 1, 1:(n - 2)))
  set_class(x, "mcmcarray")
}

#' @export
as.mcmcarray.mcmcarray <- function(x, ...) x

#' @export
as.mcmcarray.mcmc <- function(x, ...) {
  if(npars(x) != 1) error("x must only have 1 parameter")

  pdims <- pdims(x)[[1]]
  x <- x[,order(terms(x)), drop = FALSE]
  x <- array(data = as.vector(x), dim = c(1, niters(x), pdims))
  set_class(x, "mcmcarray")
}

#' @method as.mcmcarray mcmc.list
#' @export
as.mcmcarray.mcmc.list <- function(x, ...) as.mcmcarray(as.mcmcr(x))

#' @export
as.mcmcarray.mcmcr <- function(x, ...) {
  if(npars(x) != 1) error("x must only have 1 parameter")
  x[[1]]
}

#' @export
as.mcmcr.list <- function(x, ...) {
  check_length(x)
  check_named(x, unique = TRUE)

  x <- lapply(x, as.mcmcarray)

  nchains <- vapply(x, nchains, 1L)
  niters <- vapply(x, niters, 1L)

  if (!identical(length(unique(nchains)), 1L))
    error("all objects must have the same number of chains")

  if (!identical(length(unique(niters)), 1L))
    error("all objects must have the same number of iterations")

  set_class(x, "mcmcr")
}

#' @export
as.mcmcr.mcarray <- function(x, ...) as.mcmcr(as.mcmcarray(x))

#' @export
as.mcmcr.mcmc <- function(x, ...) {
  parameters <- parameters(x)
  x <- lapply(parameters, function(p, x) subset(x, parameters = p), x = x)
  x <- lapply(x, as.mcmcarray)
  names(x) <- parameters
  set_class(x, "mcmcr")
}

#' @export
as.mcmcr.mcmc.list <- function(x, ...) {
  x <- lapply(x, as.mcmcr)
  Reduce(bind_chains, x)
}

#' @export
as.mcmcr.mcmcarray <- function(x, ...) set_class(list(x), "mcmcr")

#' @export
as.mcmcr.mcmcr <- function(x, ...) x

#' @export
as.mcmcrs.list <- function(x, ...) {
  check_length(x)
  if (!all(vapply(x, is.mcmcr, TRUE)))
    error("all objects must inherit from mcmcr")

  nchains <- vapply(x, nchains, 1L)
  niters <- vapply(x, niters, 1L)
  pdims <- lapply(x, pdims)
  parameters <- lapply(x, parameters)

  if (!identical(length(unique(nchains)), 1L))
    error("all objects must have the same number of chains")

  if (!identical(length(unique(niters)), 1L))
    error("all objects must have the same number of iterations")

  if (!identical(length(unique(parameters)), 1L))
    error("all objects must have the same parameters")

  if (!identical(length(unique(pdims)), 1L))
    error("all objects must have the same parameter dimensions")

  if(is.null(names(x))) {
    names(x) <- paste0("mcmcr", 1:length(x))
  } else
    if(anyDuplicated(names(x))) error("mcmcr objects must have unique names")
  set_class(x, "mcmcrs")
}

#' @export
as.mcmcrs.mcmcrs <- function(x, ...) x

