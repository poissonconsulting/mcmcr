context("extra")

test_that("extra", {
  expect_identical(pow(5,2), 25)
  expect_identical(phi(0), 0.5)
  expect_equal(phi(2), 0.9772499, tolerance = 0.0000001)
  x <- NA
  log(x) <- log(5)
  expect_equal(x, 5)
  expect_equal(logit(0.5), 0)
  expect_equal(logit(1), Inf)
  x <- NA
  logit(x) <- logit(0.75)
  expect_equal(x, 0.75)
  expect_equal(ilogit(logit(0.67)), 0.67)
})
