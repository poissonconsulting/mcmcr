#' Check mcmcarray
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
  x_name <- chk_deparse(x_name)
  check_string(x_name)
  chk_flag(error)

  check_inherits(x, "mcmcarray", x_name = x_name)
  if(!is.array(x)) err(x_name, " must be an array")
  if(anyNA(x)) err(x_name, " must not include missing values")
  invisible(x)
}

#' Check mcmcr
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
  x_name <- chk_deparse(x_name)
  chk_flag(sorted)
  check_string(x_name)
  chk_flag(error)

  check_inherits(x, "mcmcr", x_name = x_name)
  check_named(x, unique = TRUE)
  if(sorted) check_sorted(names(x), x_name = p0("names of ", x_name), error = error)
  mapply(check_mcmcarray, x, x_name = p0("parameter '", pars(x), "' of ", x_name),
         MoreArgs = list(error = error))
  invisible(x)
}
