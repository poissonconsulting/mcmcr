#' Combine MCMC Samples of multiple objects
#'
#' Combines samples of multiple MCMC objects
#' (with the same parameters, chains and iterations) using a function.
#'
#' @param x An MCMC object (or a list of mcmc objects).
#' @param fun A function.
#' @param ... Additional MCMC objects.
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
  check_list(x)
  check_length(x)

  names(x) <- NULL
  x$fun <- fun
  x <- c(x, list(...))

  do.call("combine_samples_n", x)
}
