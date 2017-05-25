context("transform")

test_that("logit", {
  x <- seq(0, 1, by = 0.25)
  expect_identical(logit(x), qlogis(x))
  expect_identical(ilogit(logit(x)), x)

  logit(x) <- c(0.5, 1)
  expect_identical(x, logit(c(0.5, 1)))

  log(x) <- c(0.5, 1)
  expect_identical(x, log(c(0.5, 1)))
})

