#' Parameters
#'
#' Gets the parameter names for an object.
#'
#' @param x The object.
#' @param ... Not used.
#' @return A character vector of the parameter names.
#' @export
parameters <- function(x, ...) UseMethod("parameters")

#' Parameters
#'
#' Sets the parameter names for an object.
#'
#' @param x The object.
#' @param value A character vector of the parameter names.
#' @export
`parameters<-` <- function(x, value) UseMethod("parameters<-", x)

#' @export
parameters.term <- function(x, ...) unique(parameters_term(x))

#' @export
parameters.mcmc <- function(x, ...) parameters(as.term(colnames(x)))

#' @export
parameters.mcmc.list <- function(x, ...) parameters(x[[1]])

#' @export
parameters.mcmcr <- function(x, ...) names(x)

#' @export
`parameters<-.mcmc` <- function(x, value) {
  check_vector(value, "", length = npars(x), unique = TRUE)
  if(npars(x) == 1) {
    colnames(x) <- paste0(value, colnames(x))
    return(x)
  }
  x
}

#' @export
`parameters<-.mcmc.list` <- function(x, value) {
  x <- lapply(x, set_parameters, parameters = value)
  class(x) <- "mcmc.list"
  x
}

#' @export
`parameters<-.mcmcr` <- function(x, value) {
  check_vector(value, "", length = length(x), unique = TRUE)
  names(x) <- value
  x
}
