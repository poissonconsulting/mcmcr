#' Term coefficients
#'
#' Gets coefficients for all the terms in an MCMC object.
#'
#' @inheritParams params
#' @return An data frame of the coefficients with the columns indicating the
#' `term`, `estimate`,
#' `lower` and `upper` credible intervals and `svalue`
#' @export
#' @seealso [stats::coef]
#' @examples
#' coef(mcmcr_example, directional_information = FALSE)
#' coef(mcmcr_example, directional_information = TRUE)
#' @name coef
NULL

warn_default_directional_information <- function(
  fun = "coef",
  env = parent.frame(),
  user_env = parent.frame(2)
) {
  lifecycle::deprecate_soft(
    "0.7.0",
    paste0(fun, "(directional_information = 'should be explicitly set')"),
    details = paste(
      "The default value of `directional_information` will change from",
      "`FALSE` to `TRUE` in a future release."
    ),
    env = env,
    user_env = user_env
  )
}

# .simplify is a necessary hack to stop apply using simplify argument!
coef_numeric_impl <- function(
  object,
  conf_level,
  estimate,
  .simplify,
  directional_information
) {
  simplify <- .simplify
  chk_number(conf_level)
  chk_range(conf_level)
  chk_function(estimate)
  chk_flag(simplify)
  chk_flag(directional_information)

  if (!simplify) {
    lifecycle::deprecate_stop("0.4.1", "coef(simplify = 'must be TRUE')")
  }

  lower <- (1 - conf_level) / 2
  upper <- conf_level + lower

  quantiles <- stats::quantile(
    object,
    c(lower, upper),
    na.rm = TRUE,
    names = FALSE
  )

  if (anyNA(object) || identical(length(object), 1L)) {
    quantiles[c(1, 2)] <- NA
  }

  estimate <- estimate(object)
  if (!identical(length(estimate), 1L)) {
    abort_chk("`estimate` must return a scalar")
  }

  svalue <- if (directional_information) {
    extras::directional_information(object)
  } else {
    extras::svalue(object)
  }
  tibble(
    estimate = estimate,
    lower = quantiles[1],
    upper = quantiles[2],
    svalue = svalue
  )
}

#' @export
coef.numeric <- function(
  object,
  conf_level = 0.95,
  estimate = median,
  simplify = TRUE,
  directional_information = FALSE,
  ...
) {
  if (simplify && missing(directional_information)) {
    warn_default_directional_information()
  }
  coef_numeric_impl(
    object,
    conf_level = conf_level,
    estimate = estimate,
    .simplify = simplify,
    directional_information = directional_information
  )
}

#' @export
coef.mcarray <- function(
  object,
  conf_level = 0.95,
  estimate = median,
  simplify = TRUE,
  directional_information = FALSE,
  ...
) {
  if (simplify && missing(directional_information)) {
    warn_default_directional_information()
  }
  coef(
    as.mcmc.list(object),
    conf_level = conf_level,
    estimate = estimate,
    simplify = simplify,
    directional_information = directional_information
  )
}

#' @describeIn coef Get coefficients for terms in mcmc object
#' @export
coef.mcmc <- function(
  object,
  conf_level = 0.95,
  estimate = median,
  simplify = TRUE,
  directional_information = FALSE,
  ...
) {
  if (simplify && missing(directional_information)) {
    warn_default_directional_information()
  }
  term <- as_term(object)
  object <- t(object)
  object <- apply(
    object,
    MARGIN = 1,
    FUN = coef_numeric_impl,
    conf_level = conf_level,
    estimate = estimate,
    .simplify = simplify,
    directional_information = directional_information
  )
  object <- do.call(rbind, object)
  object$term <- term
  colnames <- c("term", "estimate", "lower", "upper", "svalue")
  object <- object[colnames]
  object <- object[order(object$term), ]
  object
}

#' @export
coef.mcmc.list <- function(
  object,
  conf_level = 0.95,
  estimate = median,
  simplify = TRUE,
  directional_information = FALSE,
  ...
) {
  if (simplify && missing(directional_information)) {
    warn_default_directional_information()
  }
  object <- as.mcmc(collapse_chains(object))
  coef(
    object,
    conf_level = conf_level,
    estimate = estimate,
    simplify = simplify,
    directional_information = directional_information
  )
}

#' @export
coef.mcmcarray <- function(
  object,
  conf_level = 0.95,
  estimate = median,
  simplify = TRUE,
  directional_information = FALSE,
  ...
) {
  if (simplify && missing(directional_information)) {
    warn_default_directional_information()
  }
  coef(
    as.mcmc.list(object),
    conf_level = conf_level,
    estimate = estimate,
    simplify = simplify,
    directional_information = directional_information
  )
}

#' @export
coef.mcmcr <- function(
  object,
  conf_level = 0.95,
  estimate = median,
  simplify = TRUE,
  directional_information = FALSE,
  ...
) {
  if (simplify && missing(directional_information)) {
    warn_default_directional_information()
  }
  coef(
    as.mcmc.list(object),
    conf_level = conf_level,
    estimate = estimate,
    simplify = simplify,
    directional_information = directional_information
  )
}
