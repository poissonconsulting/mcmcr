#' Coerce object to term vector.
#'
#' @param x The object to coerce
#' @param ... Unused.
#' @export
#' @examples
#' as.term(mcmcr_example)
as.term <- function(x, ...) {
  UseMethod("as.term")
}

#' Coerce character vector to term vector
#'
#' @param x The character vector to coerce
#' @param ... Unused.
#' @export
as.term.character <- function(x, ...) set_class(x, c("term", "character"))

#' @export
as.term.mcmc <- function(x, ...) as.term(colnames(x))

#' @export
as.term.mcmc.list <- function(x, ...) as.term(x[[1]])

#' @export
as.term.mcmcarray <- function(x, ...) {
  x <- pdims(x)

  if(identical(x, 1L)) return(as.term("parameter"))

  if(identical(length(x), 1L))
    return(as.term(paste0("parameter[", 1:x, "]")))

  x <- lapply(x, function(x) 1:x)
  x <- expand.grid(x)
  x <- as.matrix(x)
  x <- apply(x, 1, function(x) paste(x, collapse = ","))
  x <- paste0("parameter[", x, "]")
  as.term(x)
}

#' @export
as.term.mcmcr <- function(x, ...) {
  parameters <- parameters(x)
  x <- lapply(x, terms)
  x <- mapply(x, parameters, FUN = function(x, y) {sub("parameter", y, x, fixed = TRUE)},
                   SIMPLIFY = FALSE)
  as.term(unname(unlist(x)))
}


#' @export
terms.mcmc <- function(x, ...) as.term(x)

#' @export
terms.mcmc.list <- function(x, ...) as.term(x)

#' @export
terms.mcmcarray <- function(x, ...) as.term(x)

#' @export
terms.mcmcr <- function(x, ...) as.term(x)

#' @export
as.character.term <- function(x, ...) set_class(x, "character")

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
