#' @export
terms.mcmcarray <- function(x, ...) {
  x %<>% subset(1L, 1L)
  x %<>% drop() %>% unclass()
  x %<>% reshape2::melt()
  if (nrow(x) == 1) return("")
  if (ncol(x) == 1) return(paste0("[", 1:nrow(x), "]"))

  x %<>% dplyr::select_(~-value)
  x %<>% tidyr::unite_("term", from = colnames(.), sep = ",") %>%
    dplyr::mutate_(term = ~paste0("[", term, "]"))

  x$term
}

#' @export
terms.mcmcr <- function(x, ...) {
  check_unused(...)

  parameters <- parameters(x)
  x %<>% lapply(terms)

  x %<>% purrr::map2(parameters, function(x, y) {x <- paste0(y, x); x})
  x %<>% unlist()
  names(x) <- NULL
  x
}
