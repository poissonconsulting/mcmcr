library(mcmcr)

rm(list = ls())

data(line, package = "coda")

mcmcr_example <- as.mcmcr(line)

stopifnot(all.equal(coda::as.mcmc.list(mcmcr_example), line, check.attributes = FALSE))

mcmcr_example$alpha <- bind_dimensions(mcmcr_example$alpha, mcmcr_example$alpha + 1)

mcmcr_example$beta <- bind_dimensions(mcmcr_example$beta, mcmcr_example$beta + 1)
mcmcr_example$beta <- bind_dimensions(mcmcr_example$beta, mcmcr_example$beta + 1, along = 1L)

devtools::use_data(mcmcr_example, overwrite = TRUE)
