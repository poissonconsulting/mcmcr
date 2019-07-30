#' Zero MCMC Sample Values
#'
#' Zeros an MCMC object's sample values.
#'
#' It is used for removing the effect of a random effect
#' where the expected value is 0.
#'
#' @param x The MCMC object.
#' @param pars A character vector (or NULL) of the pars to zero.
#' @param ... Unused
#' @return The MCMC
#' @export
#'
#' @examples
#' zero(mcmcr_example, pars = "beta")
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
zero.mcmcr <- function(x, pars = NULL, ...) {
  if(!is.null(pars)) {
    check_vector(pars, rep(pars(x), 3), unique = TRUE)
  } else
    pars <- pars(x)

  x[pars] <- lapply(x[pars], zero)
  set_class(x, "mcmcr")
}
