#' Slice mcmcr data
#'
#' @inheritParams dplyr::slice_
#' @param .data An mcmcr_data object
#' @export
slice_.mcmcr_data <- function(.data, ..., .dots){
  data <- .data$data

  stopifnot(!tibble::has_name(data, "IDX"))
  data$IDX <- 1:nrow(data)
  data %<>% dplyr::slice_(..., .dots = .dots)
  .data$mcmcr[[1]] %<>% filter_mcmcarray(data$IDX)
  data$IDX <- NULL
  .data$data <- data
  .data
}
