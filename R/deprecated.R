#' @export
terms.mcmc <- function(x, ...) {
  .Deprecated("term")
  as.term(x)
}

#' @export
terms.mcmc.list <- function(x, ...) {
  .Deprecated("term")
  as.term(x)
}

#' @export
terms.mcmcarray <- function(x, ...) {
  .Deprecated("term")
  as.term(x)
}

#' @export
terms.mcmcr <- function(x, ...) {
  .Deprecated("term")
  as.term(x)
}

#' \lifecycle{soft-deprecated} Check mcmcarray
#'
#' @param x The object to check.
#' @param x_name A string of the name of the object.
#' @param error A flag indicating whether to throw an informative error or immediately generate an informative message if the check fails.
#'
#' @return An invisible copy of x (it if doesn't throw an error).
#' @export
#'
#' @examples
#' check_mcmcarray(mcmcr::mcmcr_example$beta)
check_mcmcarray <- function(x, x_name = substitute(x), error = TRUE) {
  lifecycle::deprecate_soft("v0.2.0.9020", "check_mcmcarray()", "chk_mcmcarray()")
  x_name <- deparse_backtick_chk(x_name)
  chk_string(x_name)
  chk_flag(error)

  chk_s3_class(x, "mcmcarray", x_name = x_name)
  if(!is.array(x)) abort_chk(x_name, " must be an array")
  chk_not_any_na(x, x_name = x_name)
  invisible(x)
}

#' \lifecycle{soft-deprecated} Check mcmcr
#'
#' @param x The object to check.
#' @param sorted A flag specifying whether the parameters must be sorted.
#' @param x_name A string of the name of the object.
#' @param error A flag indicating whether to throw an informative error or immediately generate an informative message if the check fails.
#'
#' @return An invisible copy of x (it if doesn't throw an error).
#' @export
#'
#' @examples
#' check_mcmcr(mcmcr::mcmcr_example)
check_mcmcr <- function(x, sorted = FALSE, x_name = substitute(x), error = TRUE) {
  lifecycle::deprecate_soft("v0.2.0.9020", "check_mcmcr()", "chk_mcmcr()")
  x_name <- deparse_backtick_chk(x_name)
  chk_flag(sorted)
  chk_string(x_name)
  chk_flag(error)

  chk_s3_class(x, "mcmcr", x_name = x_name)
  chk_named(x)
  chk_unique(names(x))
  if(sorted) chk_sorted(names(x), x_name = p0("names of ", x_name))
  mapply(check_mcmcarray, x, x_name = p0(x_name, " parameter '", pars(x), "'"),
         MoreArgs = list(error = error))
  invisible(x)
}

