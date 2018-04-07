#' Term Dimensions
#'
#' Gets the term dimensions of an object.
#'
#' @param x The object
#' @param ... Unused.
#' @export
#' @examples
#' tdims(mcmcr_example)
tdims <- function(x, ...) UseMethod("tdims")

#' @describeIn tdims Term dimensions for an object
#' @export
tdims.default <- function(x, ...) tdims(as.term(x))

#' @describeIn tdims Term dimensions for a term vector
#' @export
tdims.term <- function(x, ...) {
  x <- sub("^(\\w+)(.*)", "\\2", x)
  x <- sub("^(\\[)(.*)(\\])$", "\\2", x)
  x <- strsplit(x, "\\s*[,]\\s*")
  x[vapply(x, function(x) identical(x, character(0)), TRUE)] <- ""
  x <- lapply(x, function(x) gsub("\\s+", "", x))
  x <- lapply(x, as.integer)
  x[is.na(x)] <- 1L
  x
}
