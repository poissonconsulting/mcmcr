#' Term Vector
#'
#' A term vector is a sortable vector of the terms from an analysis.
#' @examples
#' terms <- terms(mcmcr_example)
#' terms <- rev(terms)
#' terms
#' sort(terms)
#' @name term
NULL

#' @export
rep.term <- function(x, times, ...) {
  x <- as.character(x)
  x <- rep(x, times)
  as.term(x)
}

#' @export
`>.term` <- function(e1, e2) {
  if (identical(length(e1), 1L)) e1 <- rep(e1, length(e2))
  if (identical(length(e2), 1L)) e2 <- rep(e2, length(e1))

  mapply(e1, e2, FUN = greater_than_term, USE.NAMES = FALSE)
}

#' @export
`[.term` <- function(x, i) as.term(as.character(x)[i])
