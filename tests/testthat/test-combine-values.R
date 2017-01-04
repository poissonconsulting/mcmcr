context("combine_values")

test_that("combine_values.mcmcarray", {

  x <- mcmcr[[1]]
  x2 <- mcmcr[[1]]

#  x <- combine_values(x, x2)

  expect_is(x, "mcmcarray")
  expect_identical(x, x2)
})
