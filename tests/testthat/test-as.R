context("as")

test_that("as.mcmcr", {
  expect_is(as.mcmcr(list_mcarrays), "mcmcr")
})

test_that("as.mcmcarray", {
  expect_is(as.mcmcarray(list_mcarrays[[1]]), "mcmcarray")
})

test_that("as.mcarray", {
  expect_identical(as.mcarray(as.mcmcarray(list_mcarrays[[1]])), list_mcarrays[[1]])
})

test_that("as.mcmc.list", {
  mcmc_list1 <- as.mcmc.list(mcmcr[[1]])
  mcmc_list2 <- as.mcmc.list(mcmcr[[2]])
  mcmc_list3 <- as.mcmc.list(mcmcr[[3]])

  expect_is(mcmc_list1, "mcmc.list")
  expect_identical(coda::nchain(mcmc_list1), 2L)
  expect_identical(coda::nvar(mcmc_list2), 4L)
  expect_equal(coda::gelman.diag(mcmc_list3, transform = TRUE, autoburnin = FALSE, multivariate = FALSE)$psrf[1], 1.006437, tolerance = 1e-06)

  expect_identical(coda::nvar(as.mcmc.list(mcmcr)), 7L)
})
