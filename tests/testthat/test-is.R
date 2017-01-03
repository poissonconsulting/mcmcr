context("is")

test_that("is.mcmcr", {
  expect_true(is.mcmcr(mcmcr))
  expect_true(is.mcmcarray(mcmcr[[1]]))
})
