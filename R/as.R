#' Coerce to an mcmcr object
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @examples
#' as.mcmcr(list_mcarrays)
#' @export
as.mcmcr <- function(x, ...) {
  UseMethod("as.mcmcr")
}

#' Coerce to an mcmcrs object
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
as.mcmcrs <- function(x, ...) {
  UseMethod("as.mcmcrs")
}

#' Coerce to an mcmcarray object
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @examples
#' as.mcmcarray(list_mcarrays[[1]])
#' @export
as.mcmcarray <- function(x, ...) {
  UseMethod("as.mcmcarray")
}

#' Coerce to an mcarray object
#'
#' @param x object to coerce.
#' @param ... Unused.
#' @export
as.mcarray <- function(x, ...) {
  UseMethod("as.mcarray")
}

#' @export
as.mcmcr.list <- function(x, ...) {
  x <- lapply(x, as.mcmcarray)
  class(x) <- "mcmcr"
  x
}

#' @export
as.mcmcarray.mcarray <- function(x, ...) {
  names(dim(x)) <- NULL
  n <- ndims(x)
  x <- aperm(x, c(n, n - 1, 1:(n - 2)))
  class(x) <- "mcmcarray"
  x
}

#' @export
as.mcmcarray.numeric <- function(x, ...) {
  dim(x) <- c(1,1,length(x))
  class(x) <- "mcmcarray"
  x
}

#' @export
as.mcmcarray.matrix <- function(x, ...) {
  dim(x) <- c(1,1,dim(x))
  class(x) <- "mcmcarray"
  x
}

#' @export
as.mcarray.mcmcarray <- function(x, ...) {
  n <- ndims(x)
  names(dim(x)) <- c("chain", "iteration", rep("", n - 2))
  x <- aperm(x, c(3:n, 2, 1))
  class(x) <- "mcarray"
  x
}

as_mcmc <- function(x, ...) {
  x <- reshape2::melt(x)

  values <- x[c("Var1", "value")]
  x$Var1 <- NULL
  x$value <- NULL
  x <- tibble::tibble(
    term = apply(as.matrix(x), 1, function(x) paste(x, collapse = ","))
  )
  x$term <- paste0("[", x$term, "]")
  x <- cbind(x, values)
  x <- tidyr::spread(x, "term", "value")
  x$Var1 <- NULL
  x
}

add_colname_matrix <- function(x, name) {
  if (length(colnames(x)) == 1) {
    colnames(x) <- name
  } else {
    colnames(x) <- paste0(name, colnames(x))
  }
  x
}

#' @method as.mcmc.list mcmcarray
#' @export
as.mcmc.list.mcmcarray <- function(x, name = "", ...) {

  x <- apply(x, 1, as_mcmc)
  x <- lapply(x, as.matrix)
  x <- lapply(x, add_colname_matrix, name)
  x <- lapply(x, coda::as.mcmc)
  coda::mcmc.list(x)
}

#' @method as.mcmc.list mcmcr
#' @export
as.mcmc.list.mcmcr <- function(x, ...) {
  x <- purrr::map2(x, names(x), as.mcmc.list)
  x <- purrr::reduce(x, bind_terms)
  x
}

#' @export
as.mcmcrs.list <- function(x, ...) {
  if (length(x)) {
    if (!all(purrr::map_lgl(x, is.mcmcr)))
      error("all objects must inherit from mcmcr")

    nchains <- purrr::map_int(x, nchains)
    niters <- purrr::map_int(x, niters)
    names <- lapply(x, names)

    if (!identical(length(unique(nchains)), 1L))
      error("all objects must have the same number of chains")

    if (!identical(length(unique(niters)), 1L))
      error("all objects must have the same number of iterations")

    if (!identical(length(unique(names)), 1L))
      error("all objects must have the same names")
  }
  class(x) <- "mcmcrs"
  x
}
