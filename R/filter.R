filter_mcmcarray_vector <- function(x, idx) {
  stopifnot(is.mcmcarray(x))
  stopifnot(ndims(x) == 3)

  x <- x[,,idx,drop = FALSE]
  class(x) <- "mcmcarray"
  x
}

#' Filter mcmcr data
#'
#' @param .x The mcmcr_object to filter
#' @param ... Logical predicates. Multiple conditions are combined with &.
#' @export
filter_mcmcr_data <- function(.x, ...) {
  filter_mcmcr_data_(.x, .dots = lazyeval::lazy_dots(...))
}

#' Filter mcmcr data
#'
#' @inheritParams filter_mcmcr_data
#' @param .dots Used to work around non-standard evaluation. See vignette("nse") for details.
#' @export
filter_mcmcr_data_ <- function(.x, ..., .dots){
  data <- .x$data

  stopifnot(!tibble::has_name(data, "IDX"))
  data$IDX <- 1:nrow(data)
  data %<>% dplyr::filter_(..., .dots = .dots)
  .x$mcmcr[[1]] %<>% filter_mcmcarray_vector(data$IDX)
  .x$data <- data
  .x
}
