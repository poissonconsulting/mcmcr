#' derive
#'
#' Calculate dervived parameters.
#'
#' @param object The mcmc object.
#' @param ... Unused.
#' @return An mcmc object of the derived parameters.
#' @export
derive <- function(object, ...) {
  UseMethod("derive")
}

derive_sample <- function(i, object, expr, values, monitor) {

  object %<>% subset(iterations = i)

  object %<>% estimates()

  object %<>% c(values)

  object %<>% within(eval(expr))

  object <- object[monitor]

  object %<>% llply(function(x) { dim(x) <- c(1L, 1L, dims(x)); class(x) <- "mcmcarray"; x})

  class(object) <- "mcmcr"

  object
}

derive_chain <- function(i, object, expr = expr, values = values,
                         monitor = monitor) {

  object %<>% subset(chains = i)

  object <- llply(1:niters(object), .fun  = derive_sample, object = object,
                  expr = expr, values = values, monitor = monitor)

  object %<>% purrr::reduce(bind_iterations)
  object
}

#' derive
#'
#' Calculate dervived parameters.
#'
#' @param object The mcmcr object.
#' @param expr A string of the R expression to evaluate.
#' @param values A lists of the values to use.
#' @param monitor A regular expression specifying the new variables to monitor.
#' @param parallel A flag indicating whether to derive samples in parallel using foreach backend.
#' @param quick A flag indicating whether to quickly calculate deriveions.
#' @param ... Unused.
#' @return An mcmcr object of the monitored parameters.
#' @export
derive.mcmcr <- function(object, expr, values = list(), monitor = ".*", parallel = FALSE, quick = FALSE, ...) {

  check_string(expr)
  if (!is.list(values)) error("values must be a list")
  check_string(monitor)
  check_flag(parallel)
  check_flag(quick)

  values %<>% llply(as.numeric)

  parameters <- parameters(object)
  names_values <- names(values)
  variables_expr <- all.vars(parse(text = expr))

  if (length(values)) {
    if (is.null(names_values)) error("values must be named")
    if (anyDuplicated(names_values)) error("values names must be unique")

    parameters <- parameters[!parameters %in% names_values]

    values <- values[intersect(names_values, variables_expr)]
  }

  parameters %<>% intersect(variables_expr)

  if (!length(parameters)) error("expr must include at least one object parameter")

  object %<>% subset(parameters = parameters)

  variables_expr %<>% setdiff(parameters) %>% setdiff(names(values))

  if (!length(variables_expr)) error("expr must include at least one new variable")

  values[variables_expr] <- NA

  if (!length(variables_expr[grepl(monitor, variables_expr)]))
    error("monitor '", monitor, "' must match at least one new variable in expr\n", expr)

  monitor <- variables_expr[grepl(monitor, variables_expr)]

  monitor %<>% sort()

  if (quick) object %<>% quick_mcmcr()

  object <- llply(1:nchains(object), derive_chain, object = object,
                     .parallel = parallel, expr = parse(text = expr),
                  values = values, monitor = monitor)

  object %<>% purrr::reduce(bind_chains)

  if (anyNA(object))
    error("monitor '", monitor, "' must not include missing values in expr\n", expr)
  object
}
