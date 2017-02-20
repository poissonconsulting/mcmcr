summarise_vector_index <- function(i, vector, idx, fun) {
  fun(vector[idx == i])
}

summarise_vector <- function(x, idx, fun) {
  idxs <- unique(idx)
  idxs %<>% vapply(FUN = summarise_vector_index, FUN.VALUE = 1, vector = x, idx = idx, fun = fun, USE.NAMES = FALSE)
  idxs
}

summarise_mcmcarray_vector <- function(x, idx, fun) {
  stopifnot(is.mcmcarray(x))
  stopifnot(ndims(x) == 3)

  x %<>% plyr::aaply(.margins = c(1,2), .fun = summarise_vector, idx = idx, fun = fun, .drop = FALSE)
  class(x) <- "mcmcarray"
  x
}


#' Summarise mcmcr data
#'
#' @param .x The mcmcr_object to filter
#' @param ... Name-value pairs of summary functions like min(), mean(), max() etc.
#' @param .fun The function to summarise the samples by.
#' @export
summarise_mcmcr_data <- function(.x, ..., .fun = mean) {
  summarise_mcmcr_data_(.x, .dots = lazyeval::lazy_dots(...), .fun = .fun)
}

#' Summarise mcmcr data
#'
#' @inheritParams summarise_mcmcr_data
#' @param .dots Used to work around non-standard evaluation. See vignette("nse") for details.
#' @export
summarise_mcmcr_data_ <- function(.x, ..., .dots, .fun = mean){
  if (is.null(dplyr::groups(.x$data))) error("mcmcr_data must be grouped to summarize")
  IDX <- dplyr::group_indices(.x$data)
  .x$mcmcr[[1]] %<>% summarise_mcmcarray_vector(IDX, fun = .fun)
  .x$data %<>% dplyr::summarise_(..., .dots = .dots)
  .x
}

#' Summarise mcmcr data
#'
#' @inheritParams summarise_mcmcr_data
#' @export
summarize_mcmcr_data <- function(.x, ..., .fun = mean) {
  summarise_mcmcr_data(.x, ..., .fun = .fun)
}

#' Summarise mcmcr data
#'
#' @inheritParams summarise_mcmcr_data
#' @param .dots Used to work around non-standard evaluation. See vignette("nse") for details.
#' @export
summarize_mcmcr_data_ <- function(.x, ..., .dots, .fun = mean){
  summarise_mcmcr_data_(.x, ..., .dots = .dots, .fun = .fun)
}
