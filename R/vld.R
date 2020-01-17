#' Validate MCMC Objects
#'
#' Validates structure of MCMC objects.
#'
#' To validate the class use \code{\link[chk]{vld_s3_class}(x, "class")}.
#'
#' @inheritParams chk::chk_true
#' @return A flag indicating whether the object was validated.
#' @seealso [chk_mcmcr()]
#' @name vld_mcmcr
NULL

#' @describeIn vld_mcmcr Validate [mcmcarray-object()]
#'
#' @export
#'
#' @examples
#' #' vld_mcmcarray
#' vld_mcmcarray(1)
vld_mcmcarray <- function(x) {
  is.array(x) && is.numeric(x)
}

#' @describeIn vld_mcmcr Validate [mcmcr-object()]
#'
#' @export
#'
#' @examples
#'
#' # vld_mcmcr
#' vld_mcmcr(1)
#' vld_mcmcr(as.mcmcr(list(x = 1)))
vld_mcmcr <- function(x) {
  vld_list(x) && vld_named(x) && vld_unique(names(x)) &&
    vld_all(x, vld_mcmcarray)
}
