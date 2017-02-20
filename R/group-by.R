#' Group mcmcr data
#'
#' @param .x The mcmcr_object to group
#' @param ... variables to group by. All tbls accept variable names, some will also accept functions of variables. Duplicated groups will be silently dropped.
#' @param add By default, when add = FALSE, group_by will override existing groups. To instead add to the existing groups, use add = TRUE
#' @export
group_by_mcmcr_data <- function(.x, ..., add = FALSE) {
  group_by_mcmcr_data_(.x, .dots = lazyeval::lazy_dots(...), add = add)
}

#' Group mcmcr data
#'
#' @inheritParams group_by_mcmcr_data
#' @param .dots Used to work around non-standard evaluation. See vignette("nse") for details.
#' @export
group_by_mcmcr_data_ <- function(.x, ..., .dots, add = FALSE){
  .x$data %<>% dplyr::group_by_(..., .dots = .dots, add = add)
  .x
}

#' Ungroup mcmcr data
#'
#' @inheritParams group_by_mcmcr_data
#' @param ... Additional arguments that maybe used by methods.
#' @export
ungroup_mcmcr_data <- function(.x, ...){
  .x$data %<>% dplyr::ungroup(...)
  .x
}
