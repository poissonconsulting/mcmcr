#' Group mcmcr data
#'
#' @inheritParams dplyr::group_by
#' @param .data An mcmcr_data object
# missing from dplyr documentation!!
#' @param .dots Used to work around non-standard evaluation.
#' See \code{vignette("nse")} for details.
#' @export
group_by_.mcmcr_data <- function(.data, ..., .dots, add = FALSE){
  .data$data <- dplyr::group_by_(.data$data, ..., .dots = .dots, add = add)
  .data
}

#' Ungroup mcmcr data
#'
#' @inheritParams dplyr::group_by
#' @param x An mcmcr_data object
#' @export
ungroup.mcmcr_data <- function(x, ...){
  x$data <- dplyr::ungroup(x$data, ...)
  x
}
