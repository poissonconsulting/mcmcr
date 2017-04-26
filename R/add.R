#' Add mcmcr(s)
#'
#' @param x An mcmcr or mcmcrs object.
#' @param x2 An mcmcr or mcmcrs object.
#' @return An object of class mcmcrs.
#' @export
add_mcmcrs <- function(x, x2) {
  if (is.mcmcr(x)) x %<>% list()
  if (is.mcmcr(x2)) x2 %<>% list()
  x %<>% c(x2)
  as.mcmcrs(x)
}
