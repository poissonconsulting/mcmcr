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
  object <- apply(object, 3:ndims, FUN = fun, ...)

  if (as_list) return(object)

  object <- reshape2::melt(object)

  if (nrow(object) == 1) {
    object$term <- ""
  } else {
    values <- object["value"]
    if (ncol(object) == 1) object$Var1 <- 1:nrow(object)

    object$value <- NULL

    object <- tidyr::unite(object, "term", from = colnames(object), sep = ",")
    object$term <- paste0("[", object$term, "]")
    object <- cbind(object, values)
  }
  object$term <- as.term(object$term)
  object <- object[c("term", "value")]
  colnames(object) <- c("term", "estimate")
  tibble::as_tibble(object)
}

#' @export
estimates.mcmcr <- function(object, fun = stats::median, as_list = TRUE, ...) {
  object <- lapply(object, estimates, fun = fun, as_list = as_list, ...)
  if (as_list) return(object)

  object <- purrr::map2(object, names(object), function(x, y) {x$id = y; x})
  object <- do.call(rbind, object)
  object <-  tidyr::unite(object, "term", from = c("id", "term"), sep = "")
  object$term <- as.term(object$term)
  object
}
