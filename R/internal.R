subset_mcmcarray_iteration <- function(x, iteration) {
  x <- abind::asub(x, iteration, 2L, drop = FALSE)
  dim <- dim(x)[-c(1,2)]
  if(length(dim) == 1) dim <- NULL
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
.esr <- function(x, ...) {
  stopifnot(is.matrix(x))
  niters <- niters(x)
  x <- apply(x, 1L, .esr_numeric)
  x <- unlist(x)
  round(mean(x), 3)
}

.esr_numeric <- function(x) {
  stopifnot(is.numeric(x))
  x <- stats::acf(x, lag.max = length(x) - 1, plot = FALSE)$acf[,,1]

  if (is.nan(x[1])) return(1) # all values identical

  x <- c(x, -1) # adds stopper
  match <- match(TRUE, x < 0)
  x <- sum(x[1:(match-1)]) - 1 # drops lag-0
  1 / (1 + 2 * x)
}

#' @export
.estimates <- function(object, fun = stats::median) {
  stopifnot(is.matrix(object))
  nrow <- nrow(object)
  object <- apply(object, 1L, fun)
  if(!identical(dims(object), nrow)) err("function fun must return a scalar")
  if(!is.numeric(object)) err("function fun must return a numeric")
  object
}

#' @export
.rhat <- function(x) {
  stopifnot(is.matrix(x))

  niters <- niters(x)
  nchains <- nchains(x)

  mean_chain <- apply(x, 1L, mean)
  var_chain <- apply(x, 1L, stats::var)

  var_between <- niters * stats::var(mean_chain)
  var_within <- mean(var_chain)
  rhat <- sqrt((var_between/var_within + niters - 1) / niters)

  if (is.nan(rhat) || (!is.na(rhat) && rhat < 1)) rhat <- 1
  round(rhat, 3)
}

.thin <- function(x, nthin = 1L, ...) {
  check_vector(nthin, c(1L, niters(x)), length = 1)
  iterations <- seq(1L, niters(x), by = nthin)
  subset(x, iterations = iterations)
}

tibble <- function(...) {
  data <- data.frame(..., stringsAsFactors = FALSE)
  class(data) <- c("tbl_df", "tbl", "data.frame")
  data
}

abind <- function(x, x2, along, dimnames = TRUE) {
  x <- abind::abind(x, x2, along = along)
  if(!isTRUE(dimnames)) dimnames(x) <- NULL
  x
}
