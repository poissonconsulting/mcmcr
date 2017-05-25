#' Logistic Transformation
#'
#' @param x The numeric vector to transform.
#' @export
#' @examples
#' logit(c(0.25,0.5,0.75))
logit <- function(x) {
  log(x / (1 - x))
}

#' Logistic Transformation
#'
#' @param x The object to replace.
#' @param value The numeric vector to transform
#' @export
#' @examples
#' x <- 1
#' logit(x) <- 0.5
#' x
`logit<-` <- function(x, value) {
  x <- logit(value)
  x
}

#' Inverse Logistic Transformation
#'
#' @param x The numeric vector to transform.
#' @export
#' @examples
#' ilogit(c(0.25,0.5,0.75))
ilogit <- function(x) {
  1 / (1 + exp(-x))
}

#' Inverse Logistic Transformation
#'
#' @param x The object to replace.
#' @param value The numeric vector to transform
#' @export
#' @examples
#' x <- 1
#' ilogit(x) <- 0.5
#' x
`ilogit<-` <- function(x, value) {
  x <- ilogit(value)
  x
}

