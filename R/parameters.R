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
parameters.term <- function(x, scalar_only = FALSE, terms = FALSE, ...) {
  check_flag(scalar_only)
  check_flag(terms)

  x <- as.character(x)
  if(scalar_only) x <- x[!grepl("\\[", x)]
  x <- sub("^(\\w+)(.*)", "\\1", x)
  if(!terms) x <- unique(x)
  x
}

#' @export
parameters.mcmc <- function(x, scalar_only = FALSE, terms = FALSE, ...)
  parameters(as.term(x), scalar_only = scalar_only, terms = terms)

#' @export
parameters.mcmc.list <- function(x, scalar_only = FALSE, terms = FALSE, ...)
  parameters(x[[1]], scalar_only = scalar_only, terms = terms)

#' @export
parameters.mcmcr <- function(x, scalar_only = FALSE, terms = FALSE, ...) {
  if(!scalar_only && !terms) return(names(x))

}

`parameters<-.term` <- function(x, value) {
  check_vector(value, "", length = npars(x), unique = TRUE)

  parameters <- parameters(x)
  terms <- x

  for(i in seq_along(value)) {
    which <- which(grepl(parameters[i], terms, fixed = TRUE))
    x[which] <- sub(parameters[i], value[i], x[which], fixed = TRUE)
  }
  x
}

#' @export
`parameters<-.mcmc` <- function(x, value) {
  terms <- set_parameters(terms(x), value)
  colnames(x) <- as.character(terms)
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
