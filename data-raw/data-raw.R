rm(list = ls())

library(abind)
library(rjags)
library(devtools)
library(mcmcr)

data(LINE)
LINE$recompile()
list_mcarrays <- jags.samples(LINE, c("alpha","beta","sigma"),
                        n.iter = 1000)

list_mcarrays$alpha <- abind(list_mcarrays$alpha, list_mcarrays$alpha + 1, along = 1)
dim(list_mcarrays$alpha) <- c(2, iteration = 1000, chain = 2)
class(list_mcarrays$alpha) <- "mcarray"

list_mcarrays$beta <- abind(list_mcarrays$beta, list_mcarrays$beta + 1, along = 1)
list_mcarrays$beta <- abind(list_mcarrays$beta, list_mcarrays$beta + 1, along = 2)
dim(list_mcarrays$beta) <- c(2, 2, iteration = 1000, chain = 2)
class(list_mcarrays$beta) <- "mcarray"

use_data(list_mcarrays, overwrite = TRUE)

mcmcr <- as.mcmcr(list_mcarrays)
use_data(mcmcr, internal = TRUE, overwrite = TRUE)
