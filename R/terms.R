#' Number of terms.
#'
#' @param x The object to calculate the number of terms for.
#' @param ... Not used.
#' @return A count of the number of terms.
#' @export
nterms <- function(x, ...) {
  UseMethod("nterms")
}

#' @export
nterms.mcmcarray <- function(x, ...) {
  as.integer(prod(dim(x)[-(1:2)]))
}

#' @export
nterms.mcmcr <- function(x, ...) {
  sum(vapply(x, nterms, 1L))
}

#' @export
terms.mcmcarray <- function(x, ...) {
  x <- subset(x, 1L, 1L)
  x <- drop(x)
  x <- unclass(x)
  x <- reshape2::melt(x)
  if (nrow(x) == 1) return(as.term(""))
  if (ncol(x) == 1) return(as.term(paste0("[", 1:nrow(x), "]")))

  x <- dplyr::select_(x, ~-value)
  x <- tidyr::unite_(x, "term", from = colnames(x), sep = ",")
  x <- dplyr::mutate_(x, term = ~paste0("[", term, "]"))

  as.term(x$term)
}

#' @export
terms.mcmcr <- function(x, ...) {
  parameters <- parameters(x)
  x <- llply(x, terms)

  x <- purrr::map2(x, parameters, function(x, y) {x <- paste0(y, x); x})
  x <- unlist(x)
  names(x) <- NULL
  as.term(x)
}
