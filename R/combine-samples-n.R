#' Combines multiple object samples.
#'
#' Combines mcmc objects by values using fun.
#'
#' @param x An mcmc object (or a list of mcmc objects).
#' @param fun A function.
#' @param ... Additional mcmc objects (or unused).
#' @export
#' @examples
#' combine_samples_n(mcmcr_example, mcmcr_example, mcmcr_example, fun = sum)
combine_samples_n <- function(x, ..., fun = mean) {
  UseMethod("combine_samples_n")
}

#' @export
combine_samples_n.default <- function(x, ..., fun = mean) {
  if(!length(list(...))) return(x)
  x <- bind_dimensions_n(x, ...)
  combine_dimensions(x, fun = fun)
}

#' @export
combine_samples_n.list <- function(x, ..., fun = mean) {
  check_list(x, length = TRUE)
  check_unused(...)

  check_missing_names(x, "fun")
  names(x) <- NULL
  x$fun <- fun

  do.call("combine_samples_n", x)
}
