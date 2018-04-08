#' Combine Samples by Dimensions
#'
#' Combines MCMC object samples by dimensions along \code{along} using \code{fun}.
#'
#' @param x An MCMC object
#' @param fun The function to use when combining dimensions
#' @param along A positive interger (or NULL) indicating the parameter dimension(s) to bind along.
#' @param ... Unused
#' @return The MCMC object with reduced dimensions.
#' @export
#' @examples
#' combine_dimensions(mcmcr_example$alpha)
combine_dimensions <- function(x, fun = mean, along = NULL, ...) {
  UseMethod("combine_dimensions")
}

#' @describeIn combine_dimensions Combine an mcmcarray object's samples by dimensions
#' @export
combine_dimensions.mcmcarray <- function(x, fun = mean, along = NULL, ...) {
  check_function(fun)
  checkor(check_null(along), check_vector(along, c(1L, length(pdims(x))), length = 1))
  check_unused(...)

  pdims <- pdims(x)
  if(is.null(along)) along <- length(pdims)

  n <- 1:length(pdims)
  n <- n[-along]
  if(length(pdims) > 1) {
    pdims <- pdims[-along]
  } else
    pdims <- 1L
  dim <- c(nchains(x), niters(x), pdims)
  x <- apply(x, c(1L, 2L, n + 2L), fun)
  dim(x) <- dim
  x <- set_class(x, "mcmcarray")

  if(!identical(pdims(x), pdims)) error("function fun must return a scalar")
  x
}

#' @describeIn combine_dimensions Combine an mcmcr object's samples by dimensions
#' @export
combine_dimensions.mcmcr <- function(x, fun = mean, along = NULL, ...) {
  check_function(fun)
  check_unused(...)

  pdims <- pdims(x)
  lengths <- vapply(pdims, length, 1L)

  checkor(check_null(along),
          check_vector(along, c(1L, min(lengths)), length = 1L),
          check_vector(along, c(1L, max(lengths)), length = length(x)))

  if(is.null(along)) {
    along <- lengths
  } else if(identical(length(along), 1L))
    along <- rep(along, length(pdims))

  x <- mapply(FUN = combine_dimensions, x = x, along = along, MoreArgs = list(fun = fun),
              SIMPLIFY = FALSE)
  set_class(x, "mcmcr")
}
