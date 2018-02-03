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

  coef <- reshape2::melt(coef)

  values <- coef[c("Var1", "value")]
  coef$Var1 <- NULL
  coef$value <- NULL
  coef <- tidyr::unite(coef, "term", from = colnames(coef), sep = ",")
  coef$term <- paste0("[", coef$term, "]")
  coef <- dplyr::bind_cols(coef, values)
  coef$term <- factor(coef$term, levels = unique(coef$term))
  coef <- tidyr::spread(coef, "Var1", "value")
  coef$term <- as.character(coef$term)
  if (nrow(coef) == 1) coef$term = ""
  coef$term <- as.term(coef$term)
  dplyr::as.tbl(coef)
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

  object <- lapply(object, coef, conf_level = conf_level, estimate = estimate)
  suppressWarnings(object <- dplyr::bind_rows(object, .id = "id"))
  object <-  tidyr::unite(object, "term", from = c("id", "term"), sep = "")

  object$term <- as.term(object$term)

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
  dplyr::bind_cols(object$data, coef)
}
