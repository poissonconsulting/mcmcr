context("checkr")

test_that("check_mcmcarray",{
  expect_identical(check_mcmcarray(mcmcr::mcmcr_example$sigma), mcmcr::mcmcr_example$sigma)
  expect_error(check_mcmcarray(1), "^`1` must inherit from S3 class 'mcmcarray'[.]$",
               class = "chk_error")

  x <- set_class(1, "mcmcarray")
  expect_error(check_mcmcarray(x), "^`x` must be an array[.]$",
               class = "chk_error")

  sigma <- mcmcr::mcmcr_example$sigma
  is.na(sigma[2,2,1]) <- TRUE
  expect_error(check_mcmcarray(sigma), "^`sigma` must not have any missing values[.]$",
               class = "chk_error")
})

test_that("check_mcmcr",{
  expect_identical(check_mcmcr(mcmcr::mcmcr_example), mcmcr::mcmcr_example)
  expect_identical(check_mcmcr(mcmcr::mcmcr_example, sorted = TRUE), mcmcr::mcmcr_example)
  expect_error(check_mcmcr(1), "^`1` must inherit from S3 class 'mcmcr'[.]$",
               class = "chk_error")

  y <- set_class(list(x = 1), "mcmcr")
  expect_error(check_mcmcr(y),
               "^`\"`y` parameter 'x'\"` must inherit from S3 class 'mcmcarray'[.]$",
               class = "chk_error")

  mcmcr <- mcmcr::mcmcr_example
  is.na(mcmcr$sigma[2,2,1]) <- TRUE
  expect_error(check_mcmcr(mcmcr), "`\"`mcmcr` parameter 'sigma'\"` must not have any missing values", class = "chk_error")
})
