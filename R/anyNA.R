#' @export
anyNA.mcarray <- function(x, recursive = FALSE) anyNA(unclass(x))

#' @export
anyNA.mcmc <- function(x, recursive = FALSE) anyNA(unclass(x))

#' @export
anyNA.mcmc.list <- function(x, recursive = FALSE) any(vapply(x, anyNA, TRUE))

#' @export
anyNA.mcmcarray <- function(x, recursive = FALSE) anyNA(unclass(x))

#' @export
anyNA.mcmcr <- function(x, recursive = FALSE) any(vapply(x, anyNA, TRUE))

#' @export
anyNA.mcmcrs <- function(x, recursive = FALSE) any(vapply(x, anyNA, TRUE))
