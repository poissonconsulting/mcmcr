#' Coerce object to term vector.
#'
#' @param x The object to coerce
#' @param ... Unused.
#' @export
as.term <- function(x, ...) {
  UseMethod("as.term")
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
as.term.mcmc <- function(x, ...) {
  as.term(colnames(x))
}

#' @export
as.term.mcmc.list <- function(x, ...) {
  as.term(x[[1]])
}

#' @export
as.term.mcmcarray <- function(x, ...) {
  x <- subset(x, 1L, 1L)
  x <- drop(x)
  x <- unclass(x)
  x <- reshape2::melt(x)
  if (nrow(x) == 1) return(as.term(""))
  if (ncol(x) == 1) return(as.term(paste0("[", 1:nrow(x), "]")))

  x$value <- NULL
  x <- tibble::tibble(
    term = apply(as.matrix(x), 1, function(x) paste(x, collapse = ","))
  )
  x$term <- paste0("[", x$term, "]")

  as.term(x$term)
}

#' @export
as.term.mcmcr <- function(x, ...) {
  parameters <- parameters(x)
  x <- lapply(x, terms)

  x <- mapply(x, parameters, FUN = function(x, y) {x <- paste0(y, x); x},
                   SIMPLIFY = FALSE)
  x <- unlist(x)
  names(x) <- NULL
  as.term(x)
}

#' @export
as.character.term <- function(x, ...) {
  class(x) <- "character"
  x
}

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
