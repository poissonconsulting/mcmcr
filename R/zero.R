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
  lifecycle::deprecate_soft("v0.3.0", "zero()", "fill_all()")
  UseMethod("zero")
}

#' @describeIn zero Zero an mcarray object
#' @export
zero.mcarray <- function(x, ...)
  fill_all(x)

#' @describeIn zero Zero an mcmcarray object
#' @export
zero.mcmcarray <- function(x, ...)
  fill_all(x)

#' @describeIn zero Zero an mcmcr object
#' @export
zero.mcmcr <- function(x, pars = NULL, ...) {
  if(!is.null(pars)) {
    chk_s3_class(pars, "character")
    chk_subset(pars, pars(x))
    chk_unique(pars)
  } else
    pars <- pars(x)

  x[pars] <- lapply(x[pars], zero)
  set_class(x, "mcmcr")
}
