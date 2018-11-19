#' Coerce to a term vector
#'
#' Coerces MCMC objects to a term vector.
#'
#' @param x The object to coerce
#' @param ... Unused.
#' @export
#' @examples
#' as.term(mcmcr_example)
as.term <- function(x, ...) {
  UseMethod("as.term")
}

#' Coerce to an mcarray object
#'
#' Coerces MCMC objects to an \code{\link[rjags]{mcarray.object}}.
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
#' @examples
#' as.mcarray(mcmcr_example$beta)
as.mcarray <- function(x, ...) UseMethod("as.mcarray")

#' Coerce to an mcmc object
#'
#' Coerces MCMC objects to an \code{\link[coda]{mcmc}} object.
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
#' @seealso \code{coda::\link[coda]{mcmc}}
#' @examples
#' as.mcmc(subset(mcmcr_example, chains = 1L))
#' @name as.mcmc
NULL

#' Coerce to an mcmcarray object
#'
#' Coerces MCMC objects to an \code{\link{mcmcarray-object}}.
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
#' @examples
#' as.mcmcarray(as.mcarray(mcmcr_example$beta))
as.mcmcarray <- function(x, ...) UseMethod("as.mcmcarray")

#' Coerce to an mcmcr object
#'
#' Coerces MCMC objects to an \code{\link{mcmcr-object}}.
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
#' @examples
#' as.mcmcr(coda::as.mcmc.list(mcmcr_example))
as.mcmcr <- function(x, ...) UseMethod("as.mcmcr")

#' Coerce to an mcmcrs object
#'
#' Coerces MCMC objects to an \code{\link{mcmcrs-object}}.
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
#' @examples
#' as.mcmcrs(list(mcmcr_example))
as.mcmcrs <- function(x, ...) UseMethod("as.mcmcrs")

#' @describeIn as.term Coerces term vector to a character vector
#' @export
as.character.term <- function(x, ...) set_class(x, "character")

#' @describeIn as.term Coerces character vector to a term vector
#' @export
as.term.character <- function(x, ...) set_class(x, c("term", "character"))

#' @describeIn as.term Coerces mcmc object to a term vector
#' @export
as.term.mcmc <- function(x, ...) as.term(colnames(x))

#' @describeIn as.term Coerces mcmc.list object to a term vector
#' @export
as.term.mcmc.list <- function(x, ...) as.term(x[[1]])

#' @describeIn as.term Coerces mcmcarray object to a term vector
#' @export
as.term.mcmcarray <- function(x, ...) {
  x <- pdims(x)

  if(identical(x, 1L)) return(as.term("parameter"))

  if(identical(length(x), 1L))
    return(as.term(paste0("parameter[", 1:x, "]")))

  x <- lapply(x, function(x) 1:x)
  x <- expand.grid(x)
  x <- as.matrix(x)
  x <- apply(x, 1, function(x) paste(x, collapse = ","))
  x <- paste0("parameter[", x, "]")
  as.term(x)
}

#' @describeIn as.term Coerces mcmcr object to a term vector
#' @export
as.term.mcmcr <- function(x, ...) {
  parameters <- parameters(x)
  x <- lapply(x, terms)
  x <- mapply(x, parameters, FUN = function(x, y) {sub("parameter", y, x, fixed = TRUE)},
                   SIMPLIFY = FALSE)
  as.term(unname(unlist(x)))
}

#' @export
as.mcarray.default <- function(x, ...) as.mcarray(as.mcmcarray(x))

#' @export
as.mcarray.mcarray <- function(x, ...) x

#' @describeIn as.mcarray Coerces mcmcarray object to an mcarray object
#' @export
as.mcarray.mcmcarray <- function(x, ...) {
  n <- ndims(x)
  names(dim(x)) <- c("chain", "iteration", rep("", n - 2))
  x <- aperm(x, c(3:n, 2, 1))
  set_class(x, "mcarray")
}

#' @describeIn as.mcmc Coerces mcarray object (with 1 chain) to an mcmc object
#' @export
as.mcmc.mcarray <- function(x, ...) as.mcmc(as.mcmcarray(x))

#' @describeIn as.mcmc Coerces mcmcarray object (with 1 chain) to an mcmc object
#' @export
as.mcmc.mcmcarray <- function(x, ...) {
  if(nchains(x) != 1) err("x must only have 1 chain")
  terms <- terms(x)
  x <- apply(x, 1, identity)
  x <- matrix(x, ncol = length(terms))
  colnames(x) <- as.character(terms)
  as.mcmc(x)
}

#' @export
as.mcmc.mcmc <- function(x, ...) x

#' @describeIn as.mcmc Coerces mcmc.list object (with 1 chain) to an mcmc object
#' @method as.mcmc mcmc.list
#' @export
as.mcmc.mcmc.list <- function(x, ...) {
  if(nchains(x) != 1) err("x must only have 1 chain")
  x[[1]]
}

#' @describeIn as.mcmc Coerces mcmcr object (with 1 chain) to an mcmc object
#' @export
as.mcmc.mcmcr <- function(x, ...) as.mcmc(as.mcmc.list(x))

#' @describeIn as.mcmcarray Coerces vector, matrix or array to an mcmcarray object
#' @export
as.mcmcarray.default <- function(x, ...) {
   dim(x) <- c(1,1,dims(x))
   set_class(x, "mcmcarray")
}

#' @describeIn as.mcmcarray Coerces mcarray object to an mcmcarray object
#' @export
as.mcmcarray.mcarray <- function(x, ...) {
  dim(x) <- unname(dim(x))
  n <- ndims(x)
  x <- aperm(x, c(n, n - 1, 1:(n - 2)))
  set_class(x, "mcmcarray")
}

#' @export
as.mcmcarray.mcmcarray <- function(x, ...) x

#' @describeIn as.mcmcarray Coerces mcmc object (with one parameter) to an mcmcarray object
#' @export
as.mcmcarray.mcmc <- function(x, ...) {
  if(npars(x) != 1) err("x must only have 1 parameter")

  pdims <- pdims(x)[[1]]
  x <- x[,order(terms(x)), drop = FALSE]
  x <- array(data = as.vector(x), dim = c(1, niters(x), pdims))
  set_class(x, "mcmcarray")
}

#' @describeIn as.mcmcarray Coerces mcmc.list object (with one parameter) to an mcmcarray object
#' @method as.mcmcarray mcmc.list
#' @export
as.mcmcarray.mcmc.list <- function(x, ...) as.mcmcarray(as.mcmcr(x))

#' @describeIn as.mcmcarray Coerces mcmcr object (with one parameter) to an mcmcarray object
#' @export
as.mcmcarray.mcmcr <- function(x, ...) {
  if(npars(x) != 1) err("x must only have 1 parameter")
  x[[1]]
}

#' @describeIn as.mcmcr Coerces list (of mcmcarray objects) to an mcmcr object
#' @export
as.mcmcr.list <- function(x, ...) {
  check_length(x)
  check_named(x, unique = TRUE)

  x <- lapply(x, as.mcmcarray)

  nchains <- vapply(x, nchains, 1L)
  niters <- vapply(x, niters, 1L)

  if (!identical(length(unique(nchains)), 1L))
    err("all objects must have the same number of chains")

  if (!identical(length(unique(niters)), 1L))
    err("all objects must have the same number of iterations")

  set_class(x, "mcmcr")
}

#' @describeIn as.mcmcr Coerces mcarray object to an mcmcr object
#' @export
as.mcmcr.mcarray <- function(x, ...) as.mcmcr(as.mcmcarray(x))

#' @describeIn as.mcmcr Coerces mcmc object to an mcmcr object
#' @export
as.mcmcr.mcmc <- function(x, ...) {
  parameters <- parameters(x)
  x <- lapply(parameters, function(p, x) subset(x, parameters = p), x = x)
  x <- lapply(x, as.mcmcarray)
  names(x) <- parameters
  set_class(x, "mcmcr")
}

#' @describeIn as.mcmcr Coerces mcmc.list object to an mcmcr object
#' @export
as.mcmcr.mcmc.list <- function(x, ...) {
  x <- lapply(x, as.mcmcr)
  Reduce(bind_chains, x)
}

#' @describeIn as.mcmcr Coerces mcmcarray object to an mcmcr object
#' @export
as.mcmcr.mcmcarray <- function(x, ...) set_class(list(x), "mcmcr")

#' @export
as.mcmcr.mcmcr <- function(x, ...) x

#' @describeIn as.mcmcr Coerces list (of mcmcr objects with the same parameters, chains and iterations) to an mcmcrs object
#' @export
as.mcmcrs.list <- function(x, ...) {
  check_length(x)
  if (!all(vapply(x, is.mcmcr, TRUE)))
    err("all objects must inherit from mcmcr")

  nchains <- vapply(x, nchains, 1L)
  niters <- vapply(x, niters, 1L)
  pdims <- lapply(x, pdims)
  parameters <- lapply(x, parameters)

  if (!identical(length(unique(nchains)), 1L))
    err("all objects must have the same number of chains")

  if (!identical(length(unique(niters)), 1L))
    err("all objects must have the same number of iterations")

  if (!identical(length(unique(parameters)), 1L))
    err("all objects must have the same parameters")

  if (!identical(length(unique(pdims)), 1L))
    err("all objects must have the same parameter dimensions")

  if(is.null(names(x))) {
    names(x) <- paste0("mcmcr", 1:length(x))
  } else
    if(anyDuplicated(names(x))) err("mcmcr objects must have unique names")
  set_class(x, "mcmcrs")
}

#' @export
as.mcmcrs.mcmcrs <- function(x, ...) x
