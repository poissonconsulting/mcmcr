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
  expect_error(as.mcmc.list(mcmcr[[1]]))
  expect_error(as.mcmc.list(mcmcr))
})
