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

test_that("combine_values.mcmr", {

  x <- mcmcr
  x2 <- mcmcr

  x <- combine_values(x, x2, mean)

  expect_is(x, "mcmcr")
  expect_equal(x, x2, check.attributes = FALSE)

  x <- combine_values(x, x2, sum)
  expect_equal(x$alpha[1,1,1], x2$alpha[1,1,1] * 2)
  expect_equal(combine_values(x, x2), combine_values(list(x, x2)))
})
