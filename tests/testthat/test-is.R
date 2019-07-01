context("is")

test_that("is", {
  expect_true(is.mcmcarray(mcmcr_example[[1]]))
  expect_true(is.mcmcr(mcmcr_example))
  expect_true(is.mcmcrs(mcmcrs(mcmcr_example)))
})
