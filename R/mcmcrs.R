#' Create mcmcrs
#'
#' Creates an [mcmcrs-object()] from multiple \code{link{mcmcr-object}}s.
#'
#' @param ... Objects of class mcmcr.
#' @return An object of class mcmcrs
#' @family coerce
#' @export
#' @examples
#' mcmcrs(mcmcr_example, mcmcr_example)
mcmcrs <- function(...) {
  as.mcmcrs(list(...))
}
