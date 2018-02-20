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
#' @return A tidy tibble of the coeffcient terms.
#' @export
coef.mcmcarray <- function(object, conf_level = 0.95, estimate = median, ...) {
  check_probability(conf_level)
  check_function(estimate)

  ndims <- ndims(object)
  coef <- apply(object, 3:ndims, coefs, conf_level = conf_level, estimate = estimate)

  coef <- reshape2::melt(coef)

  values <- coef[c("Var1", "value")]
  coef$Var1 <- NULL
  coef$value <- NULL
  coef <- tibble::tibble(
    term = apply(as.matrix(coef), 1, function(x) paste(x, collapse = ","))
  )
  coef$term <- paste0("[", coef$term, "]")
  coef <- cbind(coef, values)
  coef$term <- factor(coef$term, levels = unique(coef$term))
  coef <- reshape2::dcast(coef, term ~ Var1)
  coef$term <- as.character(coef$term)
  if (nrow(coef) == 1) coef$term = ""
  coef$term <- as.term(coef$term)
  tibble::as_tibble(coef)
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
  check_probability(conf_level)
  check_function(estimate)

  object <- lapply(object, coef, conf_level = conf_level, estimate = estimate)
  object <- mapply(object, names(object), FUN = function(x, y) {x$id = y; x},
                        SIMPLIFY = FALSE)
  object <- do.call(rbind, object)
  object$term <- paste0(object$id, object$term)
  object$id <- NULL

  object$term <- as.term(object$term)

  object
}
