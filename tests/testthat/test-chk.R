test_that("chk_mcmcarray", {
  expect_null(chk_mcmcarray(as.mcmcarray(1)))
  expect_invisible(chk_mcmcarray(as.mcmcarray(1)))
  expect_error(
    chk_mcmcarray(1),
    "^`1` must inherit from S3 class 'mcmcarray'",
    class = "chk_error"
  )
  x <- 1
  class(x) <- "mcmcarray"
  expect_error(
    chk_mcmcarray(x),
    "^`x` must be an array[.]$",
    class = "chk_error"
  )
  x <- array(TRUE)
  class(x) <- "mcmcarray"
  expect_error(
    chk_mcmcarray(x),
    "^`x` must be numeric[.]$",
    class = "chk_error"
  )
})

test_that("chk_mcmcr", {
  expect_null(chk_mcmcr(as.mcmcr(list(x = 1))))
  expect_invisible(chk_mcmcr(as.mcmcr(list(x = 1))))
  expect_error(
    chk_mcmcr(1),
    "^`1` must inherit from S3 class 'mcmcr'",
    class = "chk_error"
  )
  x <- list(x = 1)
  class(x) <- "mcmcr"

  expect_error(
    chk_mcmcr(x),
    "^All elements of `x` must inherit from S3 class 'mcmcarray'",
    class = "chk_error"
  )
})

test_that("chk_mcmcrs", {
  expect_null(chk_mcmcrs(as.mcmcrs(mcmcr_example)))
  expect_invisible(chk_mcmcr(as.mcmcr(list(x = 1))))
  expect_error(
    chk_mcmcr(1),
    "^`1` must inherit from S3 class 'mcmcr'",
    class = "chk_error"
  )
  x <- list(x = 1)
  class(x) <- "mcmcr"

  expect_error(
    chk_mcmcr(x),
    "^All elements of `x` must inherit from S3 class 'mcmcarray'",
    class = "chk_error"
  )
})

test_that("chk_mcmcr checks parameter names", {
  x <- structure(list(mcmcr_example$alpha), class = "mcmcr")
  expect_error(chk_mcmcr(x), "^`x` must be named[.]$", class = "chk_error")

  x <- structure(
    list(alpha = mcmcr_example$alpha, alpha = mcmcr_example$alpha),
    class = "mcmcr"
  )
  expect_error(
    chk_mcmcr(x),
    "^names\\(`x`\\) must be unique[.]$",
    class = "chk_error"
  )
})
