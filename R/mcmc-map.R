#' MCMC Map
#'
#' Adjust the sample values of an MCMC object using a function.
#'
#' @param .x An MCMC object
#' @param .f The function to use
#' @param .by A positive integer vector of the dimensions to apply the function over.
#' @param ... Additional arguments passed to .f.
#' @return The updated MCMC object.
#' @export
#' @examples
#' mcmc_map(mcmcr_example$beta, exp)
mcmc_map <- function(.x, .f, .by = 1:npdims(.x), ...) {
  UseMethod("mcmc_map")
}

#' @export
mcmc_map.mcmcarray <- function(.x, .f, .by = 1:npdims(.x), ...) {
  by_all <- 1:npdims(.x)

  if(!vld_flag(.by)) {
    chk_whole_numeric(.by)
    chk_subset(.by, by_all)
    chk_unique(.by)
    chk_sorted(.by)
  }

  if(isTRUE(.by)) .by <- by_all
  if(isFALSE(.by)) .by <- NULL

  x <- apply(.x, MARGIN = c(1L, 2L, .by + 2L), FUN = .f, ...)

  if(!identical(prod(dims(x)), prod(dims(.x))))
    err("mcmc_map() function .f did not preserve the dimensions.")

  if(!identical(.by, by_all)) {
    by_perm <- if(is.null(.by)) NULL else 1:length(.by)
    x <- aperm(x, perm = c(2L, 3L, by_perm + 3L, 1L))
  }
  if(!identical(dims(x), dims(.x))) {
    by_missing <- setdiff(by_all, .by)
    dim(x) <- dim(.x)[c(1L, 2L, .by + 2L, by_missing + 2L)]
    x <- aperm(x, perm = c(1L, 2L, order(c(.by, by_missing)) + 2L))
  }

  if(!identical(dims(x), dims(.x)))
    err("mcmc_map() function .f did not preserve the dimensions.")
  return(set_class(x, "mcmcarray"))
}

#' @export
mcmc_map.mcmc <- function(.x, .f, .by = TRUE, ...) {
  x <- as.mcmcr(.x)
  x <- mcmc_map(x, .f = .f, .by = .by, ...)
  as.mcmc(x)
}

#' @export
mcmc_map.mcmc.list <- function(.x, .f, .by = TRUE, ...) {
  x <- lapply(.x, mcmc_map, .f = .f, .by = .by, ...)
  set_class(x, "mcmc.list")
}

#' @export
mcmc_map.mcmcr <- function(.x, .f, .by = TRUE, ...) {
  x <- lapply(.x, mcmc_map, .f = .f, .by = .by, ...)
  set_class(x, "mcmcr")
}

#' @export
mcmc_map.mcmcrs <- function(.x, .f, .by = TRUE, ...) {
  x <- lapply(.x, mcmc_map, .f = .f, .by = .by, ...)
  set_class(x, "mcmcrs")
}
