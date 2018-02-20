#' Coef mcmcr
#'
#' Coefficients for an mcmcr object.
#'
#' @param object The mcmcr object.
#' @param conf_level A number specifying the confidence level. By default 0.95.
#' @param estimate A The function to use to calculate the estimate.
#' @param ... Not used.
#' @return A tidy tibble of the coefficient terms.
#' @export
#' @examples
#' coef(mcmcr_example)
coef.default <- function(object, conf_level = 0.95, estimate = median, ...) {
  object <- coda::as.mcmc.list(object)
  coef(object, conf_level = conf_level, estimate = estimate)
}

#' @export
coef.numeric <- function(object, conf_level = 0.95, estimate = median, ...) {
  check_probability(conf_level)
  check_function(estimate)

  lower <- (1 - conf_level) / 2
  upper <- conf_level + lower

  quantiles <- stats::quantile(object, c(lower, upper), na.rm = TRUE, names = FALSE)

  if (anyNA(object) || identical(length(object), 1L)) quantiles[c(1,2)] <- NA

  estimate <- estimate(object)
  if(!identical(length(estimate), 1L)) error("function estimate must return a scalar")
  sd <- stats::sd(object)
  zscore = mean(object) / sd

  tibble::tibble(estimate = estimate, sd = sd, zscore = zscore,
    lower = quantiles[1], upper = quantiles[2], pvalue = pvalue(object))
}

#' @export
coef.mcmc <- function(object, conf_level = 0.95, estimate = median, ...) {
  terms <- terms(object)
  object <- t(object)
  object <- apply(object, MARGIN = 1, FUN = coef, conf_level = conf_level, estimate = estimate)
  object <- do.call(rbind, object)
  object$term <- terms
  object <- object[c("term", "estimate", "sd", "zscore", "lower", "upper", "pvalue")]
  object <- object[order(object$term),]
  object
}

#' @export
coef.mcmc.list <- function(object, conf_level = 0.95, estimate = median, ...) {
  object <- collapse_chains(object)
  coef(object, conf_level = conf_level, estimate = estimate)
}
