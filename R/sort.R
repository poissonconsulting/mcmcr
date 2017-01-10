#' @export
sort.mcmcr <- function(x, ...) {
  subset(x, parameters = sort(parameters(x)))
}
