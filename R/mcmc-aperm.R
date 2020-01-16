#' MCMC Object Transposition
#'
#' Transpose an MCMC object by permuting its parameter dimensions.
#'
#' @param x The MCMC object to transpose.
#' @param perm A integer vector of the new order for the parameter dimensions.
#' Missing parameter dimensions are added on the end.
#' If perm = NULL (the default) the parameter dimensions are reversed.
#' @param ... Unused
#' @return The modified MCMC object
#' @export
mcmc_aperm <- function(x, perm, ...) {
  UseMethod("mcmc_aperm")
}

#' @export
mcmc_aperm.mcmcarray <- function(x, perm = NULL, ...) {
  chkor(chk_null(perm),
          check_vector(perm, 1:npdims(x), only = TRUE, unique = TRUE))
  chk_unused(...)

  perm_all <- 1:npdims(x)
  perm <- c(perm, if(!is.null(perm)) setdiff(perm_all, perm) else rev(perm_all))
  perm <- c(1L, 2L, perm + 2L)
  x <- aperm(x, perm = perm)
  set_class(x, "mcmcarray")
}

#' @export
mcmc_aperm.mcmc <- function(x, perm = NULL, ...) {
  chk_unused(...)
  x <- as.mcmcr(x)
  x <- mcmc_aperm(x, perm = perm)
  as.mcmc(x)
}

#' @export
mcmc_aperm.mcmc.list <- function(x, perm = NULL, ...) {
  chk_unused(...)
  x <- lapply(x, mcmc_aperm, perm = perm)
  set_class(x, "mcmc.list")
}

#' @export
mcmc_aperm.mcmcr <- function(x, perm = NULL, ...) {
  chk_unused(...)
  x <- lapply(x, mcmc_aperm, perm = perm)
  set_class(x, "mcmcr")
}

#' @export
mcmc_aperm.mcmcrs <- function(x, perm = NULL, ...) {
  chk_unused(...)
  x <- lapply(x, mcmc_aperm, perm = perm)
  set_class(x, "mcmcrs")
}
