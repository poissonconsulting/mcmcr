#' @importFrom term as.term
#' @export
term::as.term

#' @importFrom term as_term
#' @export
term::as_term

#' @export
as_term.mcmcarray <- function(x, ...) {
  x <- pdims(x)

  if (identical(x, 1L)) {
    return(as_term("parameter"))
  }

  if (identical(length(x), 1L)) {
    return(as_term(paste0("parameter[", 1:x, "]")))
  }

  x <- lapply(x, function(x) 1:x)
  x <- expand.grid(x)
  x <- as.matrix(x)
  x <- apply(x, 1, function(x) paste(x, collapse = ","))
  x <- paste0("parameter[", x, "]")
  as_term(x)
}

#' @export
as_term.mcmcr <- function(x, ...) {
  parameters <- names(x)
  x <- lapply(x, as_term)
  x <- mapply(x, parameters,
    FUN = function(x, y) {
      sub("parameter", y, x, fixed = TRUE)
    },
    SIMPLIFY = FALSE
  )
  as_term(unname(unlist(x)))
}

#' @export
as_term.mcmcrs <- function(x, ...) as_term(x[[1]])
