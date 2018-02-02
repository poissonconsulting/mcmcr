pvalue <- function(x) {
  n <- length(x)
  d <- sum(x >= 0)
  p <- min(d, n - d) * 2
  p <- max(p, 1)
  round(p / n, 4)
}

coefs <- function(x, conf_level, estimate) {
  lower <- (1 - conf_level) / 2
  upper <- conf_level + lower

  quantiles <- stats::quantile(x, c(lower, upper), na.rm = TRUE, names = FALSE)

  if (any(is.na(x)) || identical(length(x), 1L)) quantiles[c(1,2)] <- NA

  estimate <- estimate(x)
  sd <- stats::sd(x)
  zscore = mean(x) / sd

  c(estimate = estimate, sd = sd, zscore = zscore,
    lower = quantiles[1], upper = quantiles[2], pvalue = pvalue(x))
}

#' Coef TMB Analyses
#'
#' Coefficients for an mcmcarray object.
#'
#' @param object The list of tmb_analysis objects.
#' @param conf_level A number specifying the confidence level. By default 0.95.
#' @param estimate The function to use to calculate the estimate.
#' @param ... Not used.
#' @return A tidy tibble of the coeffcient terms with the model averaged estimate, the
#' Akaike's weight and the proportion of models including the term.
#' @export
coef.mcmcarray <- function(object, conf_level = 0.95, estimate = median, ...) {

  check_vector(conf_level, c(0.5, 0.99), length = 1)

  ndims <- ndims(object)
  coef <- apply(object, 3:ndims, coefs, conf_level = conf_level, estimate = estimate)

  coef %<>% reshape2::melt()

  values <- dplyr::select_(coef, ~Var1, ~value)
  coef %<>% dplyr::select_(~-Var1, ~-value)
  coef %<>% tidyr::unite_("term", from = colnames(.), sep = ",") %>%
    dplyr::mutate_(term = ~paste0("[", term, "]"))
  coef %<>% dplyr::bind_cols(values)
  coef %<>% dplyr::mutate_(term = ~factor(term, levels = unique(term)))
  coef %<>% tidyr::spread_("Var1", "value")
  coef %<>% dplyr::mutate_(term = ~as.character(term))
  if (nrow(coef) == 1) coef %<>% dplyr::mutate_(term = ~"")
  coef$term %<>% as.term()
  coef %<>% dplyr::as.tbl()
  coef
}

#' Coef mcmcr
#'
#' Coefficients for an mcmcr object.
#'
#' @param object The mcmcr object.
#' @param conf_level A number specifying the confidence level. By default 0.95.
#' @param estimate The function to use to calculate the estimate.
#' @param ... Not used.
#' @return A tidy tibble of the coefficient terms.
#' @export
coef.mcmcr <- function(object, conf_level = 0.95, estimate = median, ...) {
  check_vector(conf_level, c(0.5, 0.99), length = 1)

  object %<>% llply(coef, conf_level = conf_level, estimate = estimate)
  suppressWarnings(object %<>% dplyr::bind_rows(.id = "id"))
  object %<>%  tidyr::unite_("term", from = c("id", "term"), sep = "")

  object$term %<>% as.term()

  object
}

#' Coef mcmcr data
#'
#' Coefficients for an mcmcr_data object.
#'
#' @param object The mcmcr_data object.
#' @param conf_level A number specifying the confidence level. By default 0.95.
#' @param ... Not used.
#' @return A tidy tibble of the coefficient terms.
#' @export
coef.mcmcr_data <- function(object, conf_level = 0.95, ...) {
  coef <- coef(object$mcmcr, conf_level = conf_level, ...)
  coef %<>% dplyr::bind_cols(object$data, .)
  coef
}
