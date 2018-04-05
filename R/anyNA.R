#' Any Missing Values
#'
#' Test whether there are any missing values.
#'
#' @param x The object to test.
#' @param recursive Unused.
#' @return A flag indicating whether there are any missing values.
#' @seealso \code{base::\link[base]{anyNA}}
#' @examples
#' anyNA(mcmcr_example)
#' anyNA(mcmcr_example$beta)
#'
#' @name anyNA
NULL

#' @rdname anyNA
#' @export
anyNA.mcarray <- function(x, recursive = FALSE) anyNA(unclass(x))

#' @rdname anyNA
#' @export
anyNA.mcmc <- function(x, recursive = FALSE) anyNA(unclass(x))

#' @rdname anyNA
#' @export
anyNA.mcmc.list <- function(x, recursive = FALSE) any(vapply(x, anyNA, TRUE))

#' @rdname anyNA
#' @export
anyNA.mcmcarray <- function(x, recursive = FALSE) anyNA(unclass(x))

#' @rdname anyNA
#' @export
anyNA.mcmcr <- function(x, recursive = FALSE) any(vapply(x, anyNA, TRUE))

#' @rdname anyNA
#' @export
anyNA.mcmcrs <- function(x, recursive = FALSE) any(vapply(x, anyNA, TRUE))
