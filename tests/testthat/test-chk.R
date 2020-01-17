context("chk")

test_that("chk_mcmcarray", {
  expect_null(chk_mcmcarray(as.mcmcarray(1)))
  expect_invisible(chk_mcmcarray(as.mcmcarray(1)))
  expect_error(chk_mcmcarray(1), "^`1` must be an array[.]$",
               class = "chk_error")
  expect_error(chk_mcmcarray(array(TRUE)), "^`array[(]TRUE[)]` must be numeric[.]$",
               class = "chk_error")
})

test_that("chk_mcmcr", {
  expect_null(chk_mcmcr(as.mcmcr(list(x = 1))))
  expect_invisible(chk_mcmcr(as.mcmcr(list(x = 1))))
  expect_error(chk_mcmcr(1), "^`1` must inherit from S3 class 'mcmcr'[.]$",
               class = "chk_error")
  x <- list(x = 1)
  class(x) <- "mcmcr"

  expect_error(chk_mcmcr(x),
               "All elements of `x` must be an array.",
               class = "chk_error")
})
