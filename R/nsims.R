#' @export
nsims.default <- function(x, ...) nchains(x) * niters(x)
