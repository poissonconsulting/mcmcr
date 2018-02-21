#' Zero
#'
#' Zeros object
#'
#' @param x The object.
#' @param ...  Not used.
#' @export
#' @examples
#' zero(mcmcr_example, parameters = "beta")
zero <- function(x, ...) {
  UseMethod("zero")
}

#' @export
zero.mcarray <- function(x, ...) set_class(array(0, dims(x)), "mcarray")

#' @export
zero.mcmcarray <- function(x, ...) set_class(array(0, dims(x)), "mcmcarray")

#' @export
zero.mcmcr <- function(x, parameters = NULL, ...) {
  checkor(check_null(parameters), check_vector(parameters, rep(parameters(x), 3), unique = TRUE))

  if(is.null(parameters)) parameters <- parameters(x)

  x[parameters] <- lapply(x[parameters], zero)
  set_class(x, "mcmcr")
}
