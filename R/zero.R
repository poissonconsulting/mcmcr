#' Zero
#'
#' Zeros object
#'
#' @param x The object.
#' @param ...  Not used.
#' @export
zero <- function(x, ...) {
  UseMethod("zero")
}

#' @export
zero.mcmcarray <- function(x, ...) {
  x <- array(0, dims(x))
  class(x) <- "mcmcarray"
  x
}

#' @export
zero.mcmcr <- function(x, parameters = NULL, ...) {


  if (!is.null(parameters)) {
    if (!all(parameters %in% parameters(x))) error("parameters must all be in x")
    if (anyDuplicated(parameters)) error("parameters must be unique")
  } else parameters <- parameters(x)

  x %<>% purrr::map_at(parameters, zero)

  class(x) <- "mcmcr"
  x
}
