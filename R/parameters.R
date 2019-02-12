#' Parameter Names
#'
#' Gets or sets the parameter names for an object.
#'
#' @param x An MCMC object.
#' @param scalar_only A flag indicating whether to only get the names of
#' parameters with one term.
#' @param terms A flag indicating whether to return the parameter name
#' for each term.
#' @param ... Not used.
#' @param value A character vector of the new parameter names.
#' @param parameters A character vector of the new parameter names.
#' @return A character vector of the parameter names.
#' @export
#' @examples
#' parameters(mcmcr_example)
#' parameters(mcmcr_example) <- c("gamma", "theta", "tau")
#' parameters(mcmcr_example)
#' parameters(mcmcr_example, scalar_only = TRUE)
#' parameters(mcmcr_example, terms = TRUE)
parameters <- function(x, ...) UseMethod("parameters")

#' @rdname parameters
#' @export
`parameters<-` <- function(x, value) UseMethod("parameters<-", x)

#' @rdname parameters
set_parameters <- function(x, parameters) {
  parameters(x) <- parameters
  x
}

#' @describeIn parameters Parameter names for a term vector
#' @export
parameters.term <- function(x, scalar_only = FALSE, terms = FALSE, ...) {
  check_flag(scalar_only)
  check_flag(terms)
  check_unused(...)

  x <- as.character(x)
  if(scalar_only) x <- x[!grepl("\\[", x)]
  x <- sub("^(\\w+)(.*)", "\\1", x)
  if(!terms) x <- unique(x)
  x
}

#' @describeIn parameters Parameter names for an mcmc object
#' @export
parameters.mcmc <- function(x, scalar_only = FALSE, terms = FALSE, ...) {
  check_unused(...)
  parameters(as.term(x), scalar_only = scalar_only, terms = terms)
}

#' @describeIn parameters Parameter names for an mcmc.list object
#' @export
parameters.mcmc.list <- function(x, scalar_only = FALSE, terms = FALSE, ...) {
  check_unused(...)
  parameters(x[[1]], scalar_only = scalar_only, terms = terms)
}
#' @describeIn parameters Parameter names for an mcmcr object
#' @export
parameters.mcmcr <- function(x, scalar_only = FALSE, terms = FALSE, ...) {
  check_unused(...)
  if(!scalar_only && !terms) return(names(x))
  parameters(as.term(x), scalar_only = scalar_only, terms = terms)
}

#' @describeIn parameters Parameter names for an mcmcrs object
#' @export
parameters.mcmcrs <- function(x, scalar_only = FALSE, terms = FALSE, ...) {
  check_unused(...)
  parameters(x[[1]], scalar_only = scalar_only, terms = terms)
}

#' @export
`parameters<-.character` <- function(x, value) {
  x <- as.term(x)
  parameters(x) <- value
  as.character(x)
}

#' @export
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

#' @export
`parameters<-.mcmcrs` <- function(x, value) {
  x <- lapply(x, `parameters<-`, value)
  class(x) <- "mcmcrs"
  x
}
