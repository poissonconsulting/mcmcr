#' Term Coefficients
#'
#' Gets coefficients for all the terms in an MCMC object.
#'
#' @param object The MCMC object to get the coefficients for
#' @param conf_level A number specifying the confidence level. By default 0.95.
#' @param estimate The function to use to calculate the estimate.
#' @param ... Unused
#' @return An tibble of the coefficients with the columns indicating the
#' \code{term}, \code{estimate}, standard deviation (\code{sd}), \code{zscore},
#' \code{lower} and \code{upper} credible intervals and \code{pvalue}.
#' @export
#' @seealso \code{stats::\link[stats]{coef}}
#' @examples
#' coef(mcmcr_example)
#' @name coef
NULL

#' @export
coef.numeric <- function(object, conf_level = 0.95, estimate = stats::median, ...) {
  check_probability(conf_level)
  check_function(estimate)

  lower <- (1 - conf_level) / 2
  upper <- conf_level + lower

  quantiles <- stats::quantile(object, c(lower, upper), na.rm = TRUE, names = FALSE)

  if (anyNA(object) || identical(length(object), 1L)) quantiles[c(1,2)] <- NA

  estimate <- estimate(object)
  if(!identical(length(estimate), 1L)) err("function estimate must return a scalar")
  sd <- stats::sd(object)
  zscore = mean(object) / sd

  tibble::tibble(estimate = estimate, sd = sd, zscore = zscore,
    lower = quantiles[1], upper = quantiles[2], pvalue = pvalue(object))
}

#' @describeIn coef Get coefficients for terms in mcarray object
#' @export
coef.mcarray <- function(object, conf_level = 0.95, estimate = stats::median, ...)
  coef(as.mcmc.list(object), conf_level = conf_level, estimate = estimate)

#' @describeIn coef Get coefficients for terms in mcmc object
#' @export
coef.mcmc <- function(object, conf_level = 0.95, estimate = stats::median, ...) {
  terms <- terms(object)
  object <- t(object)
  object <- apply(object, MARGIN = 1, FUN = coef, conf_level = conf_level, estimate = estimate)
  object <- do.call(rbind, object)
  object$term <- terms
  object <- object[c("term", "estimate", "sd", "zscore", "lower", "upper", "pvalue")]
  object <- object[order(object$term),]
  object
}

#' @describeIn coef Get coefficients for terms in mcmc.list object
#' @export
coef.mcmc.list <- function(object, conf_level = 0.95, estimate = stats::median, ...) {
  object <- collapse_chains(object)
  coef(object, conf_level = conf_level, estimate = estimate)
}

#' @describeIn coef Get coefficients for terms in mcmcarray object
#' @export
coef.mcmcarray <- function(object, conf_level = 0.95, estimate = stats::median, ...)
  coef(as.mcmc.list(object), conf_level = conf_level, estimate = estimate)

#' @describeIn coef Get coefficients for terms in mcmcr object
#' @export
coef.mcmcr <- function(object, conf_level = 0.95, estimate = stats::median, ...)
  coef(as.mcmc.list(object), conf_level = conf_level, estimate = estimate)
