library(mcmcr)
library(coda)

rm(list = ls())

data(line, package = "coda")

mcmcr_example <- as.mcmcr(line)

stopifnot(all.equal(as.mcmc.list(mcmcr_example), line, check.attributes = FALSE))

mcmcr_example$alpha <- bind_dimensions(mcmcr_example$alpha, mcmcr_example$alpha + 1, along = 1L)

mcmcr_example$beta <- bind_dimensions(mcmcr_example$beta, mcmcr_example$beta + 1)
mcmcr_example$beta <- bind_dimensions(mcmcr_example$beta, mcmcr_example$beta + 1, along = 1L)

mcmcr_example2 <- mcmcr_example
mcmcr_example2$alpha <- mcmc_map(mcmcr_example2$alpha, function(x) x + 1.5)
mcmcr_example2$beta <- mcmc_map(mcmcr_example2$beta, function(x) x + 0.33)

mcmcr_example <- bind_iterations(mcmcr_example, mcmcr_example2)

usethis::use_data(mcmcr_example, overwrite = TRUE)

mcmcr_example2 <- mcmcr_example
dim(mcmcr_example2$alpha) <- c(dims(mcmcr_example2$alpha), 1L, 1L)
mcmcr_example2$beta <- bind_dimensions(mcmcr_example2$beta, mcmcr_example2$beta + 1)
dim(mcmcr_example2$sigma) <- c(dims(mcmcr_example2$sigma), 1L, 1L)

usethis::use_data(mcmcr_example2, internal = TRUE, overwrite = TRUE)
