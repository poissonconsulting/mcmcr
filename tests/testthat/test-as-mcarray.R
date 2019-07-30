context("as.mcarray")

test_that("as.mcarray", {
  mcarrays <- lapply(mcmcr_example, as.mcarray)
  mcmcarrays <- lapply(mcarrays, as.mcmcarray)
  expect_equal(mcmcarrays, unclass(mcmcr_example), check.attributes = FALSE)
  mcarrays2 <- lapply(mcmcarrays, as.mcarray)
  expect_equal(mcarrays2, mcarrays)
  expect_equal(mcarrays[[1]], as.mcarray(mcarrays[[1]]))

  expect_error(as.mcarray(coda::as.mcmc.list(mcmcr_example)),
               "x must only have 1 parameter")

  expect_is(as.mcarray(coda::as.mcmc.list(mcmcr_example[[1]])), "mcarray")
  expect_is(as.mcarray(as.mcarray(coda::as.mcmc.list(mcmcr_example[[1]]))), "mcarray")
})