#' MCMCRs
#'
#' @param ... Objects of class mcmcr.
#'
#' @return An object of class mcmcrs
#' @export
mcmcrs <- function(...) {
  as.mcmcrs(list(...))
}
