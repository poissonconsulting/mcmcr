#' Validate MCMC Objects
#'
#' Validates class and structure of MCMC objects.
#'
#' To just validate class use \code{\link[chk]{vld_s3_class}()}.
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
  vld_s3_class(x, "mcmcarray") &&
    is.array(x) &&
    is.numeric(x)
}

#' @describeIn vld_mcmcr Validate [mcmcr-object()]
#'
#' @export
#'
#' @examples
#'
#' # vld_mcmcr
#' vld_mcmcr(1)
#' vld_mcmcr(mcmcr::mcmcr_example)
vld_mcmcr <- function(x) {
  vld_s3_class(x, "mcmcr") &&
    vld_list(x) &&
    vld_all(x, vld_mcmcarray) &&
    vld_all_identical(lapply(x, nchains)) &&
    vld_all_identical(lapply(x, niters))
}

#' @describeIn vld_mcmcr Validate [mcmcrs-object()]
#'
#' @export
#'
#' @examples
#'
#' # vld_mcmcrs
#' vld_mcmcrs(1)
vld_mcmcrs <- function(x) {
  vld_s3_class(x, "mcmcrs") &&
    vld_list(x) &&
    vld_all(x, vld_mcmcr) &&
    vld_all_identical(lapply(x, pars)) &&
    vld_all_identical(lapply(x, nchains)) &&
    vld_all_identical(lapply(x, niters))
}
