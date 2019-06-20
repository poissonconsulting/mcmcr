context("npars")

test_that("npars", {
  expect_identical(npars(mcmcr_example), 3L)
  expect_identical(npars(mcmcrs(mcmcr_example, mcmcr_example)), 3L)
  expect_identical(npars(mcmcr_example$alpha), 1L)
  expect_identical(npars(coda::as.mcmc.list(mcmcr_example)), 3L)
  expect_identical(npars(as.mcarray(mcmcr_example$beta)), 1L)
})
