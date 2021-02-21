#' @export
extras::fill_na

#' @inherit extras::fill_na
#' @inheritParams params
#' @export
fill_na.mcarray <- function(x, value = 0, ...) {
  chk_unused(...)
  x <- unclass(x)
  x <- fill_na(x, value = value)
  set_class(x, "mcarray")
}

#' @inherit extras::fill_na
#' @inheritParams params
#' @export
fill_na.mcmcarray <- function(x, value = 0, ...) {
  chk_unused(...)
  x <- unclass(x)
  x <- fill_na(x, value = value)
  set_class(x, "mcmcarray")
}

#' @inherit extras::fill_na
#' @inheritParams params
#' @export
fill_na.mcmcr <- function(x, value = 0, ...) {
  chk_unused(...)
  x <- lapply(x, fill_na, value = value)
  set_class(x, "mcmcr")
}
