context("as-mcmcr")

test_that("as.mcmcr", {
  expect_identical(as.mcmcr(unclass(mcmcr_example)), mcmcr_example)
  expect_identical(as.mcmcr(mcmcr_example), mcmcr_example)
  expect_is(as.mcmcr(as.mcarray(mcmcr_example$beta)), "mcmcr")
  expect_is(as.mcmcr(mcmcr_example$beta), "mcmcr")
})
