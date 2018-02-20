context("is")

test_that("is.mcmcr", {
  expect_true(is.mcmcarray(mcmcr::mcmcr_example[[1]]))
  expect_true(is.mcmcr(mcmcr::mcmcr_example))
  expect_true(is.mcmcrs(mcmcrs(mcmcr::mcmcr_example)))
})
