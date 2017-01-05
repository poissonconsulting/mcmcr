predict_sample <- function(object, values, expr, parameters) {
  stopifnot(nchains(object) == 1L)
  stopifnot(niters(object) == 1L)

  object %<>% estimates()

  object %<>% c(list(values))

  object %<>% within(eval(expr))

  object <- object[parameters]

  object %<>% lapply(function(x) { dim(x) <- c(1L, 1L, dims(x)); x})

  class(object) <- "mcmcr"

  object
}

#' Predict
#'
#' Calculate predictions.
#'
#' @param object The mcmcr object.
#' @param values A lists of the values to use.
#' @param expr A string of the R expression
#' @param parameters A regular expression indication the parameter to monitor.
#' @param ... Unused.
#' @return An mcmcr object of the monitored parameters.
#' @export
predict.mcmcr <- function(object, values, expr, parameters = ".*", ...) {
  check_unused(...)
  if (!is.list(values)) error("values must be a list")
  check_string(expr)
  check_vector(parameters, "")

  values %<>% lapply(as.numeric)
  expr %<>% parse(text = .)
  parameters %<>% sort()


  names_values <- names(values)
  names_expr <- all.vars(expr)

  names_expr <- names_expr()

  # object %<>% subset(parameters)

 # values[vars[!vars %in% names_values]] <- NA

  list <- list()
  for (i in 1:nchains(object)) {
    for (j in 1:niters(object)) {
      list[i][j] <- predict_sample(subset(object, i, j), values, expr, parameters)
    }
  }

  object
}
