significance <- function(x) {
  n <- length(x)
  d <- sum(x >= 0)
  p <- min(d, n - d) * 2
  p <- max(p, 1)
  round(p / n, 4)
}

coefs <- function(x, conf_level) {
  lower <- (1 - conf_level) / 2
  upper <- conf_level + lower

  quantiles <- stats::quantile(x, c(lower, upper), names = FALSE)

  estimate <- stats::median(x)
  std.error <- stats::sd(x)
  statistic = estimate / std.error

  c(estimate = estimate, std.error = std.error, statistic = statistic,
    p.value = significance(x),
    lower = quantiles[1], upper = quantiles[2])
}

#' Coef TMB Analyses
#'
#' Coefficients for an mcmcarray object.
#'
#' @param object The list of tmb_analysis objects.
#' @param conf_level A number specifying the confidence level. By default 0.95.
#' @param ... Not used.
#' @return A tidy tibble of the coeffcient terms with the model averaged estimate, the
#' Akaike's weight and the proportion of models including the term.
#' @export
coef.mcmcarray <- function(object, conf_level = 0.95, ...) {

  check_number(conf_level, c(0.5, 0.99))
  check_unused(...)


  coef <- summary(object, coefs, conf_level = conf_level)

  coef %<>% reshape2::melt()

  values <- dplyr::select_(coef, ~Var1, ~value)
  coef %<>% dplyr::select_(~-Var1, ~-value)
  coef %<>% tidyr::unite_("term", from = colnames(.), sep = ",") %>%
    dplyr::mutate_(term = ~str_c("[", term, "]"))
  coef %<>% dplyr::bind_cols(values)
  coef %<>% tidyr::spread_("Var1", "value")
  coef %<>% dplyr::as.tbl()
  coef
}

#' Coef mcmcr
#'
#' Coefficients for an mcmcr object.
#'
#' @param object The mcmcr object.
#' @param scalar_only A flag indicating whether to only return scalar terms.
#' @param constant_included A flag indicating whether to include constant terms.
#' @param conf_level A number specifying the confidence level. By default 0.95.
#' @param ... Not used.
#' @return A tidy tibble of the coeffcient terms.
coef.mcmcr <- function(object, scalar_only = FALSE, constant_included = TRUE, conf_level = 0.95, ...) {
  check_flag(scalar_only)
  check_flag(constant_included)
  check_number(conf_level, c(0.5, 0.99))
  check_unused(...)

  object %<>% lapply(coef)
  object %<>% dplyr::bind_rows()

  object
}
