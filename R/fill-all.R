#' @export
extras::fill_all

#' @inherit extras::fill_all
#' @inheritParams params
#' @export
fill_all.mcarray <- function(x, value = 0, nas = TRUE, ...) {
  chk_unused(...)
  x <- unclass(x)
  x <- fill_all(x, value = value, nas = nas)
  set_class(x, "mcarray")
}

#' @inherit extras::fill_all
#' @inheritParams params
#' @export
fill_all.mcmcarray <- function(x, value = 0, nas = TRUE, ...) {
  chk_unused(...)
  x <- unclass(x)
  x <- fill_all(x, value = value, nas = nas)
  set_class(x, "mcmcarray")
}

#' @inherit extras::fill_all
#' @inheritParams params
#' @export
fill_all.mcmcr <- function(x, value = 0, nas = TRUE, ...) {
  chk_unused(...)
  x <- lapply(x, fill_all, value = value, nas = nas)
  set_class(x, "mcmcr")
}
