context("combine_values")

test_that("combine_values.mcmcarray", {

  x <- mcmcr[[1]]
  x2 <- mcmcr[[1]]

  x <- combine_values(x, x2, mean)

  expect_is(x, "mcmcarray")
  expect_equal(x, x2, check.attributes = FALSE)

  x <- combine_values(x, x2, sum)
  expect_equal(x[1,1,1], x2[1,1,1] * 2)
})
