#' Coerce object vector to term vector.
#'
#' @param x The object to coerce
#' @param ... Unused.
#' @export
as.term <- function(x, ...) {
  UseMethod("as.term")
}

#' Parameter
#'
#' @param x The object to get the parameter(s) for.
#' @param ... Unused.
#' @export
parameter <- function(x, ...) {
  UseMethod("parameter")
}

#' Coerce character vector to term vector
#'
#' @param x The character vector to coerce
#' @param ... Unused.
#' @export
as.term.character <- function(x, ...) {
  class(x) <- c("term", "character")
  x
}

#' @export
as.character.term <- function(x, ...) {
  class(x) <- "character"
  x
}

#' Test whether an object is a term.
#' @param x The object to test.
#' @param ... Unused.
#' @export
is.term <- function(x, ...) {
  inherits(x, "term")
}

#' @export
parameter.term <- function(x, ...) {
  str_replace(x, "^(\\w+)(.*)", "\\1")
}

#' @export
rep.term <- function(x, times, ...) {
  x <- as.character(x)
  x <- rep(x, times)
  as.term(x)
}

#' Get dims for term object
#'
#' @param x The object.
#' @param ... Unused
#' @return A list of the dims.
#' @export
dims_term <- function(x, ...) {
  x <- str_replace(x, "^(\\w+)(.*)", "\\2")
  x <- str_replace(x, "^(\\[)(.*)(\\])$", "\\2")
  x <- str_split(x, "\\s*[,]\\s*")
  x <- llply(x, str_replace_all, "\\s+", "")
  x <- llply(x, as.integer)
  x <- purrr::map_if(x, function(x) identical(x, NA_integer_), function(x) 1L)
  x
}

#' @export
`>.term` <- function(e1, e2) {
  if (identical(length(e1), 1L)) e1 <- rep(e1, length(e2))
  if (identical(length(e2), 1L)) e2 <- rep(e2, length(e1))

  purrr::map2_lgl(e1, e2, greater_than_term)
}

#' @export
`[.term` <- function(x, i) {
  x <- as.character(x)
  x <- x[i]
  as.term(x)
}

greater_than_term <- function(e1, e2) {
  e1 <- as.term(e1)
  e2 <- as.term(e2)
  e1_parm <- parameter(e1)
  e2_parm <- parameter(e2)
  if (e1_parm != e2_parm) return(e1_parm > e2_parm)

  e1 <- dims_term(e1)[[1]]
  e2 <- dims_term(e2)[[1]]

  if (length(e1) != length(e2)) return(length(e1) > length(e2))

  equal <- e1 == e2

  if (all(equal)) return(FALSE)

  which <- which(!equal)
  which <- which[length(which)]

  e1[which] > e2[which]
}
