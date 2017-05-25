context("transform")

test_that("logit", {
  x <- seq(0, 1, by = 0.25)
  expect_identical(logit(x), qlogis(x))
  expect_identical(ilogit(logit(x)), x)

  logit(x) <- 0.5
  expect_equal(x, logit(0.5))
  ilogit(x) <- 0.5
  expect_equal(x, ilogit(0.5))
})

