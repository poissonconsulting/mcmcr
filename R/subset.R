#' Subset an MCMC Object
#'
#' Subsets an MCMC object by its chains, iterations and/or parameters.
#'
#' @param x The MCMC object to subset
#' @param chains An integer vector (or NULL) of the chains to subset by.
#' @param iterations An integer vector (or NULL) of the iterations to subset by.
#' @param parameters A character vector (or NULL) of the parameters to subset by.
#' @param ... Unused
#' @name subset
#' @examples
#' subset(mcmcr_example, chains = 2L, iterations = 1:100,
#'   parameters = c("beta", "alpha"))
NULL

#' @describeIn subset Subset a term object
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

#' @describeIn subset Subset an mcmc object
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

#' @describeIn subset Subset an mcmc.list object
#' @export
subset.mcmc.list <- function(x, chains = NULL, iterations = NULL, parameters = NULL, ...) {
  checkor(check_null(chains), check_vector(chains, c(1L,nchains(x))))
  if(!is.null(chains))
    x <- x[chains]
  x <- lapply(x, subset, iterations = iterations, parameters = parameters)
  class(x) <- "mcmc.list"
  x
}

#' @describeIn subset Subset an mcmcarray object
#' @export
subset.mcmcarray <- function(x, chains = NULL, iterations = NULL, ...) {
  checkor(check_null(chains), check_vector(chains, c(1L,nchains(x))))
  checkor(check_null(iterations), check_vector(iterations, c(1L,niters(x))))

  if (!is.null(chains)) x <- abind::asub(x, chains, 1L, drop = FALSE)
  if (!is.null(iterations)) x <- abind::asub(x, iterations, 2L, drop = FALSE)
  class(x) <- "mcmcarray"

  x
}

#' @describeIn subset Subset an mcmcr object
#' @export
subset.mcmcr <- function(x, chains = NULL, iterations = NULL, parameters = NULL, ...) {
  checkor(check_null(parameters),
          check_vector(parameters, parameters(x), unique = TRUE))

  if (!is.null(parameters)) x <- x[parameters]

  x <- lapply(x, subset, chains = chains, iterations = iterations)
  class(x) <- "mcmcr"
  x
}
