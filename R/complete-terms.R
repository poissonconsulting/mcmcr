#' Complete Terms
#'
#' Adds any absent elements to an mcmc object.
#'
#' The terms are repaired before being completed.
#' Missing or invalid or inconsistent terms are dropped with a warning.
#'
#' @param x An mcmc object.
#' @param silent A flag specifying whether to suppress warning messages.
#' @param ... Unused
#' @return The repaired and complete mcmc object.
#' @export
#'
#' @examples
#' mcmc <- coda::as.mcmc(subset(mcmcr::mcmcr_example, chain = 1L))
#' mcmc <- mcmc[,-c(1,5,7)]
#' term::complete_terms(mcmc)
complete_terms.mcmc <- function(x, silent = FALSE, ...) {

  check_flag(silent)
  check_unused(...)

  if(!silent && anyNA(colnames(x)))
    wrn("terms with missing values have been dropped")
  x <- x[,!is.na(colnames(x)), drop = FALSE]

  colnames(x) <- as.character(as.term(colnames(x), repair = TRUE))
  if(anyNA(!silent && anyNA(colnames(x)))) wrn("invalid terms have been dropped")
  x <- x[,!is.na(colnames(x)), drop = FALSE]

  if(!ncol(x)) return(x)

  consistent <- consistent_term(as.term(colnames(x)))
  if(anyNA(!silent && any(!consistent)))
    wrn("inconsistent terms have been dropped")
  x <- x[,consistent, drop = FALSE]

  if(!ncol(x)) return(x)

  pdims <- pdims(as.term(colnames(x)))
  absent <- setdiff(term(pdims), as.term(colnames(x)))

  if(length(absent)) {
    na <- if(is.integer(x[[1]])) NA_integer_ else NA_real_
    matrix <- matrix(na, ncol = length(absent), nrow = nrow(x))
    colnames(matrix) <- absent
    mcpar <- attr(x, "mcpar")
    x <- cbind(x, matrix)
    attr(x, "mcpar") <- mcpar
    x <- set_class(x, "mcmc")
  }
  x[,order(as.term(colnames(x))), drop = FALSE]
}
