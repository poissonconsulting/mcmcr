#' Zero MCMC Sample Values
#'
#' Zeros an MCMC object's sample values.
#'
#' It is used for removing the effect of a random effect
#' where the expected value is 0.
#'
#' @param x The MCMC object.
#' @param parameters A character vector (or NULL) of the parameters to zero.
#' @param ... Unused
#' @export
#' @examples
#' zero(mcmcr_example, parameters = "beta")
zero <- function(x, ...) {
  UseMethod("zero")
}

#' @describeIn zero Zero an mcarray object
#' @export
zero.mcarray <- function(x, ...) set_class(array(0, dims(x)), "mcarray")

#' @describeIn zero Zero an mcmcarray object
#' @export
zero.mcmcarray <- function(x, ...) set_class(array(0, dims(x)), "mcmcarray")

#' @describeIn zero Zero an mcmcr object
#' @export
zero.mcmcr <- function(x, parameters = NULL, ...) {
  checkor(check_null(parameters), check_vector(parameters, rep(parameters(x), 3), unique = TRUE))

  if(is.null(parameters)) parameters <- parameters(x)

  x[parameters] <- lapply(x[parameters], zero)
  set_class(x, "mcmcr")
}
