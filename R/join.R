#' Anti join mcmcr data
#'
#' @inheritParams dplyr::inner_join
#' @export
anti_join.mcmcr_data <- function(x, y, by = NULL, copy = FALSE, suffix = c(".x", ".y"), ...){
  stopifnot(!rlang::has_name(x$data, "IDX"))
  stopifnot(!rlang::has_name(y, "IDX"))

  x$data$IDX <- 1:nrow(x$data)
  x$data <- dplyr::anti_join(x$data, y, by = by, copy = copy, suffix = suffix)
  x$mcmcr[[1]] <- filter_mcmcarray(x$mcmcr[[1]], x$data$IDX)
  x$data$IDX <- NULL
  x
}

#' Semi join mcmcr data
#'
#' @inheritParams dplyr::inner_join
#' @export
semi_join.mcmcr_data <- function(x, y, by = NULL, copy = FALSE, suffix = c(".x", ".y"), ...){
  stopifnot(!rlang::has_name(x$data, "IDX"))
  stopifnot(!rlang::has_name(y, "IDX"))

  x$data$IDX <- 1:nrow(x$data)
  x$data <- dplyr::semi_join(x$data, y, by = by, copy = copy, suffix = suffix)
  x$mcmcr[[1]] <- filter_mcmcarray(x$mcmcr[[1]], x$data$IDX)
  x$data$IDX <- NULL
  x
}

#' Inner join mcmcr data
#'
#' @inheritParams dplyr::inner_join
#' @export
inner_join.mcmcr_data <- function(x, y, by = NULL, copy = FALSE, suffix = c(".x", ".y"), ...){
  stopifnot(!rlang::has_name(x$data, "IDX"))
  stopifnot(!rlang::has_name(y, "IDX"))

  x$data$IDX <- 1:nrow(x$data)
  x$data <- dplyr::inner_join(x$data, y, by = by, copy = copy, suffix = suffix)
  x$mcmcr[[1]] <- filter_mcmcarray(x$mcmcr[[1]], x$data$IDX)
  x$data$IDX <- NULL
  x
}

#' Inner join mcmcr data
#'
#' @inheritParams dplyr::inner_join
#' @export
left_join.mcmcr_data <- function(x, y, by = NULL, copy = FALSE, suffix = c(".x", ".y"), ...){
  x$data <- dplyr::left_join(x$data, y, by = by, copy = copy, suffix = suffix)
  x
}
