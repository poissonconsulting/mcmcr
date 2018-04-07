

#' @export
subset.term <- function(x, parameters = NULL, ...) {
  checkor(check_null(parameters),
          check_vector(parameters, parameters(x), unique = TRUE))

  if(!is.null(parameters)) {
    parameters <- paste0("(^", parameters, ("($|\\[))"))
    parameters <- paste0(parameters, collapse = ")|(")
    parameters <- paste0("(", parameters, ")", collapse = "")
    x <- x[grepl(parameters, x)]
  }
  x
}

#' @export
subset.mcmc <- function(x, iterations = NULL, parameters = NULL, ...) {
  checkor(check_null(iterations), check_vector(iterations, c(1L,niters(x))))
  checkor(check_null(parameters),
          check_vector(parameters, parameters(x), unique = TRUE))

  if (!is.null(parameters)) x <- x[,parameters(x, term = TRUE) %in% parameters,drop = FALSE]
  if (!is.null(iterations)) x <- x[iterations,,drop = FALSE]
  class(x) <- "mcmc"
  x
}

#' @export
subset.mcmc.list <- function(x, chains = NULL, iterations = NULL, parameters = NULL, ...) {
  checkor(check_null(chains), check_vector(chains, c(1L,nchains(x))))
  if(!is.null(chains))
    x <- x[chains]
  x <- lapply(x, subset, iterations = iterations, parameters = parameters)
  class(x) <- "mcmc.list"
  x
}

#' @export
subset.mcmcarray <- function(x, chains = NULL, iterations = NULL, ...) {
  checkor(check_null(chains), check_vector(chains, c(1L,nchains(x))))
  checkor(check_null(iterations), check_vector(iterations, c(1L,niters(x))))

  if (!is.null(chains)) x <- abind::asub(x, chains, 1L, drop = FALSE)
  if (!is.null(iterations)) x <- abind::asub(x, iterations, 2L, drop = FALSE)
  class(x) <- "mcmcarray"

  x
}

#' @export
subset.mcmcr <- function(x, chains = NULL, iterations = NULL, parameters = NULL, ...) {
  checkor(check_null(parameters),
          check_vector(parameters, parameters(x), unique = TRUE))

  if (!is.null(parameters)) x <- x[parameters]

  x <- lapply(x, subset, chains = chains, iterations = iterations)
  class(x) <- "mcmcr"
  x
}
