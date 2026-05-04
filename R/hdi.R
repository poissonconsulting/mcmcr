#' Highest Density Interval
#'
#' Calculates credible intervals using the empirical highest density interval
#' (HDI), i.e., the narrowest CI with the specified minimum coverage.
#'
#' @param x A numeric vector of MCMC samples.
#' @param width A number between 0 and 1 (exclusive) specifying the width of the HDI.
#' @param warn A flag indicating whether to return warnings.
#' @param na_rm A flag indicating whether to remove missing values.
#' @return A data frame of the `lower` and `upper` limits for the credible interval.
#' Note that the interval is not guaranteed to be one-sided or two-sided.
#' @export
#' @seealso [mcmcr::coef]
#' @examples
#' hdi(rnorm(1e4))
#' @name hdi
NULL

hdi <- function(x, width = 0.95, na_rm = FALSE, warn = FALSE) {
  chk_numeric(x)
  chk_number(width)
  chk_range(width)
  chk_flag(na_rm)
  chk_flag(warn)

  if (anyNA(x)) {
    if (vld_true(na_rm)) {
      x <- x[!is.na(x)]
    } else {
      return(data.frame(lower = NA_real_, upper = NA_real_))
    }
  }
  x <- sort(x)
  n <- length(x)

  if (n < 1 / (1 - width)) {
    if (warn) {
      cli::cli_warn(paste0("`length(x)` is too small to return a meaningful ",
                           width * 100, "% CI. Returning NAs."))
    }

    return(data.frame(lower = NA_real_, upper = NA_real_))
  }

  n_in <- ceiling(n * width)
  n_out <- n - n_in

  if (sum(is.infinite(x)) >= n_in) {
    if(warn) {
      cli::cli_warn("Found too many infite values to produce useful CIs. Returning Inf.")
    }

    return(data.frame(lower = Inf * sign(min(x[is.infinite(x)])),
                      upper = Inf * sign(max(x[is.infinite(x)]))))
  }

  widths <- sapply(1:n_out, function(.i) x[.i + n_in] - x[.i])
  narrowest_is <- which(widths == min(widths)) # which.min() returns first min

  if (length(narrowest_is) == 1) {
    narrowest_i <- narrowest_is
  } else {
    # not testing for non-consecutive intervals: seems inconsequential
      if (warn) {
        cli::cli_warn(paste(
          "Found", length(narrowest_is), "intervals with the same width.",
          "Returning the centermost interval of the set."))
    }
    narrowest_i <- round(median(narrowest_is))
  }

  data.frame(
    lower = x[narrowest_i],
    upper = x[narrowest_i + n_in]
  )
}
