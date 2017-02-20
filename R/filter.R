filter_mcmcarray <- function(x, idx) {
  stopifnot(is.mcmcarray(x))
  stopifnot(ndims(x) == 3)

  x <- x[,,idx,drop = FALSE]
  class(x) <- "mcmcarray"
  x
}

#' Filter mcmcr data
#'
#' @inheritParams dplyr::filter_
#' @param .x An mcmcr_data object
#' @export
filter_.mcmcr_data <- function(.x, ..., .dots){
  data <- .x$data

  stopifnot(!tibble::has_name(data, "IDX"))
  data$IDX <- 1:nrow(data)
  data %<>% dplyr::filter_(..., .dots = .dots)
  .x$mcmcr[[1]] %<>% filter_mcmcarray(data$IDX)
  .x$data <- data
  .x
}
