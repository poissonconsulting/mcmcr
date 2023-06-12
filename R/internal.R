subset_mcmcarray_iteration <- function(x, iteration) {
  x <- abind::asub(x, iteration, 2L, drop = FALSE)
  dim <- dim(x)[-c(1, 2)]
  if (length(dim) == 1) dim <- NULL
  dim(x) <- dim
  x
}

subset_iteration_mcmcr <- function(iteration, x) {
  lapply(x, subset_mcmcarray_iteration, iteration = iteration)
}

bind_iterations_mcmcarrays <- function(x) {
  x <- lapply(x, unclass)
  niters <- length(x)
  dim <- dims(x[[1]])
  dim <- c(dim, niters, 1L)
  x <- do.call("c", x)
  dim(x) <- dim
  x <- set_class(x, "mcarray")
  as.mcmcarray(x)
}

set_class <- function(x, class) {
  class(x) <- class
  x
}

#' @export
.esr <- function(x, na_rm) {
  stopifnot(is.matrix(x))
  x <- apply(x, 1L, .esr_numeric, na_rm = na_rm)
  x <- unlist(x)
  round(mean(x), 3)
}

.esr_numeric <- function(x, na_rm) {
  stopifnot(is.numeric(x))

  if (!na_rm && any(is.na(x))) {
    return(NA_real_)
  }
  x <- stats::acf(x,
    lag.max = length(x) - 1, na.action = na.pass,
    plot = FALSE
  )$acf[, , 1]

  if (is.nan(x[1])) {
    return(1)
  } # all values identical

  x <- c(x, -1) # adds stopper
  match <- match(TRUE, x < 0)
  x <- sum(x[1:(match - 1)]) - 1 # drops lag-0
  1 / (1 + 2 * x)
}

#' @export
.estimates <- function(object, fun = median, ...) {
  stopifnot(is.matrix(object))
  nrow <- nrow(object)
  object <- apply(object, 1L, fun, ...)
  if (!identical(dims(object), nrow)) abort_chk("`fun` must return a scalar")
  if (!is.numeric(object)) abort_chk("`fun` must return a numeric")
  object
}

#' @export
.rhat <- function(x, na_rm) {
  stopifnot(is.matrix(x))

  niters <- niters(x)
  nchains <- nchains(x)

  mean_chain <- apply(x, 1L, mean, na.rm = na_rm)
  var_chain <- apply(x, 1L, stats::var, na.rm = na_rm)

  var_between <- niters * stats::var(mean_chain)
  var_within <- mean(var_chain)
  rhat <- sqrt((var_between / var_within + niters - 1) / niters)

  if (is.nan(rhat) || (!is.na(rhat) && rhat < 1)) rhat <- 1
  round(rhat, 3)
}

tibble <- function(...) {
  data <- data.frame(..., stringsAsFactors = FALSE)
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}

abind <- function(x, x2, along, dimnames = TRUE) {
  x <- abind::abind(x, x2, along = along)
  if (!isTRUE(dimnames)) dimnames(x) <- NULL
  x
}

`pars<-.character` <- function(x, value) {
  x <- as_term(x)
  pars(x) <- value
  as.character(x)
}
