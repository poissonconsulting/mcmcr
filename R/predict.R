predict_sample <- function(object, expr, values, monitor) {
  object %<>% estimates()

  object %<>% c(values)

  object[monitor] <- NA

  object %<>% within(eval(expr))

  object <- object[monitor]

  object %<>% lapply(function(x) { dim(x) <- c(1L, 1L, dims(x)); class(x) <- "mcmcarray"; x})

  class(object) <- "mcmcr"

  object
}

#' Predict
#'
#' Calculate predictions.
#'
#' @param object The mcmcr object.
#' @param expr A string of the R expression to evaluate.
#' @param values A lists of the values to use.
#' @param monitor A regular expression specifying the new variables to monitor.
#' @param ... Unused.
#' @return An mcmcr object of the monitored parameters.
#' @export
predict.mcmcr <- function(object, expr, values = list(), monitor = ".*", ...) {
  
  check_string(expr)
  if (!is.list(values)) error("values must be a list")
  check_string(monitor)

  values %<>% lapply(as.numeric)
  expr %<>% parse(text = .)

  parameters <- parameters(object)
  names_values <- names(values)
  variables_expr <- all.vars(expr)

  if (length(values)) {
    if (is.null(names_values)) error("values must be named")
    if (anyDuplicated(names_values)) error("values names must be unique")

    if (length(intersect(names_values, parameters))) error("values must not include object parameters")

    values <- values[intersect(names_values, variables_expr)]
  }

  parameters %<>% intersect(variables_expr)

  if (!length(parameters)) error("expr must include at least one object parameter")

  object %<>% subset(parameters = parameters)

  variables_expr %<>% setdiff(parameters) %>% setdiff(names(values))

  if (!length(variables_expr)) error("expr must include at least one new variable")

  monitor <- variables_expr[grepl(monitor, variables_expr)]

  if (!length(monitor)) error("monitor must match at least one new variable in expr")

  monitor %<>% sort()

  list <- list()
  for (i in 1:nchains(object)) {
    list[[i]] <- list()
    for (j in 1:niters(object)) {
      list[[i]][[j]] <- predict_sample(subset(object, i, j), expr, values, monitor)
    }
  }

  object <- lapply(list, purrr::reduce, bind_iterations)
  object %<>% purrr::reduce(bind_chains)

  object
}
