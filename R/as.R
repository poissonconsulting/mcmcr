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

  x %<>% llply(as.mcmcarray)
  class(x) <- "mcmcr"
  x
}

#' @export
as.mcmcr.mcmcr_data <- function(x, ...) {
  x$mcmcr
}

#' @export
as.data.frame.mcmcr_data <- function(x, ...) {
  x$data
}

#' @export
as.mcmcarray.mcarray <- function(x, ...) {


  names(dim(x)) <- NULL
  n <- ndims(x)
  x %<>% aperm(c(n, n - 1, 1:(n - 2)))
  class(x) <- "mcmcarray"
  x
}

#' @export
as.mcarray.mcmcarray <- function(x, ...) {

  n <- ndims(x)
  names(dim(x)) <- c("chain", "iteration", rep("", n - 2))
  x %<>% aperm(c(3:n, 2, 1))
  class(x) <- "mcarray"
  x
}

as_mcmc <- function(x, ...) {
  x %<>% reshape2::melt()

  values <- dplyr::select_(x, ~Var1, ~value)
  x %<>% dplyr::select_(~-Var1, ~-value)
  x %<>% tidyr::unite_("term", from = colnames(.), sep = ",") %>%
    dplyr::mutate_(term = ~paste0("[", term, "]"))
  x %<>% dplyr::bind_cols(values)
  x %<>% tidyr::spread_("term", "value")
  x %<>% dplyr::select_(~-Var1)
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

  x %<>% apply(1, as_mcmc)
  x %<>% llply(as.matrix)
  x %<>% purrr::map(add_colname_matrix, name)
  x %<>% llply(coda::as.mcmc)
  coda::mcmc.list(x)
}

#' @method as.mcmc.list mcmcr
#' @export
as.mcmc.list.mcmcr <- function(x, ...) {

  x %<>% purrr::map2(names(x), as.mcmc.list)
  x %<>% purrr::reduce(bind_terms)
  x
}
