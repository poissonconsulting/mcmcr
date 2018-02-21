#' Power
#'
#' R equivalent to the C++  function.
#'
#' @param x A numeric vector
#' @param n A numeric vector of the power term.
#' @export
#' @examples
#' pow(10,2)
pow <- function(x, n) x^n

#' Phi
#'
#' The standard normal cumulative density function.
#'
#' @param x A numeric vector
#' @export
#' @examples
#' phi(0:2)
phi <- function(x) stats::pnorm(x)

#' Log Transformation
#'
#' @param x The object to replace.
#' @param value The numeric vector to transform
#' @export
#' @examples
#' x <- 1
#' log(x) <- 0.5
#' x
`log<-` <- function(x, value) {
  x <- exp(value)
  x
}

#' Logistic Transformation
#'
#' @param x The numeric vector to transform.
#' @export
#' @examples
#' logit(c(0.25,0.5,0.75))
logit <- function(x) log(x / (1 - x))

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
  x <- ilogit(value)
  x
}

#' Inverse Logistic Transformation
#'
#' @param x The numeric vector to transform.
#' @export
#' @examples
#' ilogit(c(0.25,0.5,0.75))
ilogit <- function(x) 1 / (1 + exp(-x))
