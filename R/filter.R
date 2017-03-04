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
#' @param .data An mcmcr_data object
#' @export
filter_.mcmcr_data <- function(.data, ..., .dots){
  data <- .data$data

  stopifnot(!tibble::has_name(data, "IDX"))
  data$IDX <- 1:nrow(data)
  data %<>% dplyr::filter_(..., .dots = .dots)
  .data$mcmcr[[1]] %<>% filter_mcmcarray(data$IDX)
  data$IDX <- NULL
  .data$data <- data
  .data
}
