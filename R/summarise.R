summarise_vector_index <- function(i, vector, idx) {
  sum(vector[idx == i])
}

summarise_vector <- function(x, idx) {
  idxs <- sort(unique(idx))
  idxs %<>% vapply(FUN = summarise_vector_index, FUN.VALUE = 1, vector = x, idx = idx, USE.NAMES = FALSE)
  idxs
}

summarise_mcmcarray <- function(x, idx) {
  stopifnot(is.mcmcarray(x))
  stopifnot(ndims(x) == 3)

  x %<>% plyr::aaply(.margins = c(1,2), .fun = summarise_vector, idx = idx, .drop = FALSE)
  class(x) <- "mcmcarray"
  x
}

#' Summarise mcmcr data
#'
#' @inheritParams dplyr::summarise_
#' @param .data An mcmcr_data object
#' @export
summarise_.mcmcr_data <- function(.data, ..., .dots){
  if (is.null(dplyr::groups(.data$data))) error("mcmcr_data must be grouped to summarize")
  IDX <- dplyr::group_indices(.data$data)
  .data$mcmcr[[1]] %<>% summarise_mcmcarray(IDX)
  .data$data %<>% dplyr::summarise_(..., .dots = .dots)
  .data
}
