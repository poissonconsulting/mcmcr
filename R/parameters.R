#' @export
parameters <- function(x, ...) {
  deprecate_soft("0.2.1", "parameters()", "pars()", id = "parameters")
  pars(x, ...)
}

#' @export
`parameters<-` <- function(x, value, ...) {
  deprecate_soft("0.2.1", "parameters()", "pars()", id = "parameters")
  pars(x) <- value
  x
}
