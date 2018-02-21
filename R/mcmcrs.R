#' MCMCRs
#'
#' @param ... Objects of class mcmcr.
#'
#' @return An object of class mcmcrs
#' @export
#' @examples
#' mcmcrs(mcmcr_example, mcmcr_example)
mcmcrs <- function(...) {
  as.mcmcrs(list(...))
}
