#' Group mcmcr data
#'
#' @inheritParams dplyr::group_by
#' @param .x An mcmcr_data object
#' @export
group_by_.mcmcr_data <- function(.x, ..., .dots, add = FALSE){
  .x$data %<>% dplyr::group_by_(..., .dots = .dots, add = add)
  .x
}

#' Ungroup mcmcr data
#'
#' @inheritParams dplyr::group_by
#' @param .x An mcmcr_data object
#' @export
ungroup.mcmcr_data <- function(.x, ...){
  .x$data %<>% dplyr::ungroup(...)
  .x
}
