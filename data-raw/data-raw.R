library(mcmcr)

rm(list = ls())

data(line, package = "coda")

mcmcr_example <- as.mcmcr(line)

stopifnot(all.equal(as.mcmc.list(mcmcr_example), line, check.attributes = FALSE))

mcmcr_example$alpha <- bind_samples(mcmcr_example$alpha, mcmcr_example$alpha + 1)

mcmcr_example$beta <- bind_samples(mcmcr_example$beta, mcmcr_example$beta + 1)
mcmcr_example$beta <- bind_samples(mcmcr_example$beta, mcmcr_example$beta + 1, along = 1)

devtools::use_data(mcmcr_example, overwrite = TRUE)
