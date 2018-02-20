#' Parameter Dimensions
#'
#' Gets the parameter dimensions of an object.
#'
#' @param x The object
#' @param ... Unused.
#' @export
pdims <- function(x, ...) UseMethod("pdims")

#' @export
pdims.term <- function(x, ...) {
  x <- sort(x)
  x <- split(x, parameters(x, terms = TRUE))
  x <- lapply(x, function(x) x[length(x)])
  x <- unlist(x)
  x <- sub("(^\\w+)(.*)", "\\2", as.character(x))
  x <- sub("^$", "1", x)
  x <- gsub("\\[|\\]", "", x)
  strsplit(x, ",")
}

#' @export
pdims.mcmc <- function(x, ...) pdims(as.term(x))

#' @export
pdims.mcmc.list <- function(x, ...) pdims(x[[1]])

#' @export
pdims.mcarray <- function(x, ...) dims(x)[1:(length(dims(x))-2)]

#' @export
pdims.mcmcarray <- function(x, ...) dims(x)[-(1:2)]

#' @export
pdims.mcmcr <- function(x, ...) lapply(x, pdims)
