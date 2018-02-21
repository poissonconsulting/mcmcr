context("transform")

test_that("transform", {
  x <- seq(0, 1, by = 0.25)
  expect_identical(logit(x), qlogis(x))
  expect_identical(ilogit(logit(x)), x)

  logit(x) <- c(0.5, 1)
  expect_identical(x, ilogit(c(0.5, 1)))

  log(x) <- c(0.5, 1)
  expect_identical(x, exp(c(0.5, 1)))

  expect_identical(pow(3,4), 3^4)
  expect_equal(phi(0:2), c(0.5, 0.8413447, 0.9772499), tolerance = 0.0000001)
})
