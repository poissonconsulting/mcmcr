context("checkr")

test_that("check_mcmcarray",{
  expect_identical(check_mcmcarray(mcmcr::mcmcr_example$sigma), mcmcr::mcmcr_example$sigma)
  expect_error(check_mcmcarray(1), "^1 must inherit from S3 class 'mcmcarray'[.]$",
               class = "chk_error")

  x <- set_class(1, "mcmcarray")
  expect_error(check_mcmcarray(x), "x must be an array")

  sigma <- mcmcr::mcmcr_example$sigma
  is.na(sigma[2,2,1]) <- TRUE
  expect_error(check_mcmcarray(sigma), "sigma must not include missing values")
})

test_that("check_mcmcr",{
  expect_identical(check_mcmcr(mcmcr::mcmcr_example), mcmcr::mcmcr_example)
  expect_identical(check_mcmcr(mcmcr::mcmcr_example, sorted = TRUE), mcmcr::mcmcr_example)
  expect_error(check_mcmcr(1), "^1 must inherit from S3 class 'mcmcr'[.]$",
               class = "chk_error")

  y <- set_class(list(x = 1), "mcmcr")
  expect_error(check_mcmcr(y),
               "^Parameter 'x' of y must inherit from S3 class 'mcmcarray'[.]$",
               class = "chk_error")

  mcmcr <- mcmcr::mcmcr_example
  is.na(mcmcr$sigma[2,2,1]) <- TRUE
  expect_error(check_mcmcr(mcmcr), "parameter 'sigma' of mcmcr must not include missing values")
})
