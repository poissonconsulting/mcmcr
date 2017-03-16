quick_mcmcr <- function(x) {
  median <- estimates(x)
  lower <- estimates(x, stats::quantile, 0.025)
  upper <- estimates(x, stats::quantile, 0.975)

  median %<>% llply(function(x) {dim(x) <- c(1L, 1L, dims(x)); class(x) <- "mcmcarray"; x})
  lower %<>% llply(function(x) {dim(x) <- c(1L, 1L, dims(x)); class(x) <- "mcmcarray"; x})
  upper %<>% llply(function(x) {dim(x) <- c(1L, 1L, dims(x)); class(x) <- "mcmcarray"; x})

  class(median) <- "mcmcr"
  class(lower) <- "mcmcr"
  class(upper) <- "mcmcr"

  median %<>% bind_iterations(lower) %>% bind_iterations(upper)
  median
}
