#' Check MCMC Objects
#'
#' Checks class and structure of MCMC objects.
#'
#' To just check class use [chk::chk_s3_class()].
#'
#' @inheritParams chk::chk_true
#' @return `NULL`, invisibly. Called for the side effect of throwing an error
#'   if the condition is not met.
#' @seealso [vld_mcmcr()]
#' @name chk_mcmcr
NULL

#' @describeIn chk_mcmcr Check mcmcarray Object
#'
#' @description
#'
#' `chk_mcmcarray`
#' checks if [mcmcarray-object()] object using
#'
#' `is.array(x) && is.numeric(x)`
#'
#' @export
#'
#' @examples
#'
#' # chk_mcmcarray
#' try(chk_mcmcarray(1))
chk_mcmcarray <- function(x, x_name = NULL) {
  if (vld_mcmcarray(x)) {
    return(invisible())
  }
  if (is.null(x_name)) x_name <- deparse_backtick_chk(substitute(x))
  chk_s3_class(x, "mcmcarray", x_name = x_name)
  chk_array(x, x_name = x_name)
  chk_numeric(x, x_name = x_name)
}

#' @describeIn chk_mcmcr Check mcmcr Object
#'
#' @description
#'
#' `chk_mcmcr`
#' checks if an [mcmcr-object()].
#'
#' @export
#'
#' @examples
#'
#' # chk_mcmcr
#' chk_mcmcr(as.mcmcr(list(x = 1)))
#' try(chk_mcmcr(1))
chk_mcmcr <- function(x, x_name = NULL) {
  if (vld_mcmcr(x)) {
    return(invisible())
  }
  if (is.null(x_name)) x_name <- deparse_backtick_chk(substitute(x))
  chk_s3_class(x, "mcmcr", x_name = x_name)
  chk_list(x, x_name = x_name)
  chk_named(x, x_name = x_name)
  if (!vld_unique(names(x))) {
    abort_chk("names(", x_name, ") must be unique.", tidy = FALSE)
  }
  chk_all(x, chk_mcmcarray, x_name = x_name)
  if (!vld_all_identical(lapply(x, nchains))) {
    abort_chk("mcmcarray elements of ", x_name, " must have the same number of chains", tidy = FALSE)
  }
  abort_chk("mcmcarray elements of ", x_name, " must have the same number of iterations", tidy = FALSE)
}

#' @describeIn chk_mcmcr Check mcmcrs Object
#'
#' @description
#'
#' `chk_mcmcrs`
#' checks if an [mcmcrs-object()].
#'
#' @export
#'
#' @examples
#'
#' # chk_mcmcrs
#' chk_mcmcrs(as.mcmcrs(as.mcmcr(list(x = 1))))
#' try(chk_mcmcrs(1))
chk_mcmcrs <- function(x, x_name = NULL) {
  if (vld_mcmcrs(x)) {
    return(invisible())
  }
  if (is.null(x_name)) x_name <- deparse_backtick_chk(substitute(x))
  chk_s3_class(x, "mcmcrs", x_name = x_name)
  chk_list(x, x_name = x_name)
  chk_all(x, chk_mcmcr, x_name = x_name)
  if (!vld_all_identical(lapply(x, pars))) {
    abort_chk("mcmcr elements of ", x_name, " must have the same parameters", tidy = FALSE)
  }
  if (!vld_all_identical(lapply(x, nchains))) {
    abort_chk("mcmcr elements of ", x_name, " must have the same number of chains", tidy = FALSE)
  }
  abort_chk("mcmcr elements of ", x_name, " must have the same number of iterations", tidy = FALSE)
}
