#' Parameter Dimensions
#'
#' Gets the parameter dimensions of an object.
#'
#' @param x The object
#' @param ... Unused.
#' @export
#' @examples
#' pdims(mcmcr_example)
pdims <- function(x, ...) UseMethod("pdims")

#' @describeIn pdims Parameter dimensions for a term vector
#' @export
pdims.term <- function(x, ...) {
  check_unused(...)
  x <- sort(x)
  x <- split(x, parameters(x, terms = TRUE))
  x <- lapply(x, function(x) x[length(x)])
  x <- unlist(x)
  x <- sub("(^\\w+)(.*)", "\\2", as.character(x))
  x <- sub("^$", "1", x)
  x <- gsub("\\[|\\]", "", x)
  x <- strsplit(x, ",")
  lapply(x, as.integer)
}

#' @describeIn pdims Parameter dimensions for an mcarray object
#' @export
pdims.mcarray <- function(x, ...) {
  check_unused(...)
  dims(x)[1:(length(dims(x))-2)]
}

#' @describeIn pdims Parameter dimensions for an mcmc object
#' @export
pdims.mcmc <- function(x, ...) {
  check_unused(...)
  pdims(as.term(x))
}

#' @describeIn pdims Parameter dimensions for an mcmc.list object
#' @export
pdims.mcmc.list <- function(x, ...) {
  check_unused(...)
  pdims(x[[1]])
}

#' @describeIn pdims Parameter dimensions for an mcmcarray object
#' @export
pdims.mcmcarray <- function(x, ...) {
  check_unused(...)
  dims(x)[-(1:2)]
}

#' @describeIn pdims Parameter dimensions for an mcmcr object
#' @export
pdims.mcmcr <- function(x, ...) {
  check_unused(...)
  lapply(x, pdims)
}
