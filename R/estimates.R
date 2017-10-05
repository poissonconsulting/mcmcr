#' Get Estimates
#'
#' Gets the estimates for an object as a named list.
#'
#' @param object The object.
#' @param ...  Not used.
#' @export
estimates <- function(object, ...) {
  UseMethod("estimates")
}


#' @export
estimates.mcmcarray <- function(object, fun = stats::median, as_list = TRUE, ...) {
  check_flag(as_list)

  ndims <- ndims(object)
  object %<>% apply(3:ndims, FUN = fun, ...)

  if (as_list) return(object)

  object %<>% reshape2::melt()

  if (nrow(object) == 1) {
    object$term <- ""
  } else {
    values <- object["value"]
    if (ncol(object) == 1) object$Var1 <- 1:nrow(object)

    object %<>%
      dplyr::select_(~-value)

    object %<>%
      tidyr::unite_("term", from = colnames(.), sep = ",") %>%
      dplyr::mutate_(term = ~paste0("[", term, "]")) %>%
      dplyr::bind_cols(values)
  }
  object$term %<>% as.term()
  object <- object[c("term", "value")]
  colnames(object) <- c("term", "estimate")
  dplyr::as.tbl(object)
}

#' @export
estimates.mcmcr <- function(object, fun = stats::median, as_list = TRUE, ...) {
  object %<>% llply(estimates, fun = fun, as_list = as_list, ...)
  if (as_list) return(object)

  suppressWarnings(object %<>% dplyr::bind_rows(.id = "id"))
  object %<>%  tidyr::unite_("term", from = c("id", "term"), sep = "")
  object$term %<>% as.term()
  object
}
