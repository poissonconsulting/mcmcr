#' @importFrom term as.term
#' @export
term::as.term

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
  parameters <- names(x)
  x <- lapply(x, as.term)
  x <- mapply(x, parameters, FUN = function(x, y) {sub("parameter", y, x, fixed = TRUE)},
                   SIMPLIFY = FALSE)
  as.term(unname(unlist(x)))
}

#' @export
as.term.mcmcrs <- function(x, ...) as.term(x[[1]])
