summarise_vector_index <- function(i, vector, idx, fun) {
  fun(vector[idx == i])
}

summarise_vector <- function(x, idx, fun) {
  idxs <- sort(unique(idx))
  idxs <- vapply(idxs, FUN = summarise_vector_index, FUN.VALUE = 1,
                   vector = x, idx = idx, fun = fun, USE.NAMES = FALSE)
  idxs
}

summarise_mcmcarray <- function(x, idx, fun) {
  stopifnot(is.mcmcarray(x))
  stopifnot(ndims(x) == 3)

  x <- plyr::aaply(x, .margins = c(1,2), .fun = summarise_vector, idx = idx,
                     fun = fun, .drop = FALSE)
  class(x) <- "mcmcarray"
  x
}

#' Summarise mcmcr data
#'
#' @inheritParams dplyr::summarise_
#' @param .data An mcmcr_data object
#' @param .fun The function to use to summarise the MCMC samples.
#' @export
summarise_.mcmcr_data <- function(.data, ..., .fun = sum, .dots){
  if (is.null(dplyr::groups(.data$data))) error("mcmcr_data must be grouped to summarize")
  IDX <- dplyr::group_indices(.data$data)
  print(.fun)
  print(alist(...))

  .data$mcmcr[[1]] <- summarise_mcmcarray(.data$mcmcr[[1]], IDX, fun = .fun)
  .data$data <- dplyr::summarise_(.data$data, ..., .dots = .dots)
  .data
}

#' Summarise mcmcr data
#'
#' @inheritParams dplyr::summarise
#' @param .data An mcmcr_data object
#' @param .fun The function to use to summarise the MCMC samples.
#' @export
summarise.mcmcr_data <- function(.data, ..., .fun = sum){
  if (is.null(dplyr::groups(.data$data))) error("mcmcr_data must be grouped to summarize")
  IDX <- dplyr::group_indices(.data$data)

  .data$mcmcr[[1]] <- summarise_mcmcarray(.data$mcmcr[[1]], IDX, fun = .fun)
  .data$data <- dplyr::summarise(.data$data, ...)
  .data
}
