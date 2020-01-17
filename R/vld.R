#' Validate MCMC Objects
#'
#' Validates class and structure of MCMC objects.
#'
#' To simply validate class use for example \code{\link[chk]{vld_s3_class}(x, "mcmcr")}.
#'
#' @inheritParams chk::chk_true
#' @return A flag indicating whether the object was validated.
#' @name vld_mcmcr
NULL

#' @describeIn vld_mcmcr Validate mcmcr Object
#'
#' @export
#'
#' @examples
#' #' vld_natomic
#' vld_mcmcarray(1)
vld_mcmcarray <- function(x) {
  vld_s3_class(x, "mcmcarray") && vld_array(x) && vld_numeric(x)
}

#' @describeIn vld_mcmcr Validate mcmcr Object
#'
#' @export
#'
#' @examples
#'
#' # vld_mcmcr
#' vld_mcmcr(1)
#' vld_mcmcr(as.mcmcr(list(x = 1)))
vld_mcmcr <- function(x) {
  vld_s3_class(x, "mcmcr") && vld_named(x) && vld_unique(names(x)) &&
    vld_all(x, vld_mcmcarray)
}

#' @describeIn vld_mcmcr Validate mcmcrs Object
#'
#' @export
#'
#' @examples
#'
#' # vld_mcmcrs
#' vld_mcmcrs(1)
vld_mcmcrs <- function(x) {
  vld_s3_class(x, "mcmcrs") && vld_all(x, vld_mcmcr)
}
