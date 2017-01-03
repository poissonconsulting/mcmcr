context("as")

test_that("as.mcmcr", {
  expect_is(as.mcmcr(list_mcarrays), "mcmcr")
})
