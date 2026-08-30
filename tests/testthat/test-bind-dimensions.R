test_that("bind_dimensions", {
  expect_identical(
    pdims(bind_dimensions(mcmcr_example$beta, mcmcr_example$beta)),
    c(2L, 2L, 2L)
  )
  expect_identical(
    pdims(bind_dimensions(mcmcr_example, mcmcr_example)),
    list(alpha = c(2L, 2L), beta = c(2L, 2L, 2L), sigma = c(1L, 2L))
  )

  expect_identical(
    pdims(bind_dimensions(mcmcr_example, mcmcr_example, along = 1L)),
    list(alpha = c(4L), beta = c(4L, 2L), sigma = c(2L))
  )

  expect_identical(
    pdims(bind_dimensions(mcmcr_example2, mcmcr_example2)),
    list(
      alpha = c(2L, 1L, 1L, 2L),
      beta = c(2L, 2L, 2L, 2L),
      sigma = c(1L, 1L, 1L, 2L)
    )
  )
})

test_that("bind_dimensions.mcmcr matches along to the parameters of x", {
  x <- structure(
    list(z = mcmcr_example$alpha, a = mcmcr_example$beta),
    class = "mcmcr"
  )

  expect_identical(
    pdims(bind_dimensions(x, x, along = c(1L, 2L))),
    list(a = c(2L, 4L), z = 4L)
  )
})

test_that("bind_dimensions.mcmcr checks the class of x2", {
  expect_error(
    bind_dimensions(mcmcr_example, mcmcr_example$alpha),
    "^`x2` must inherit from S3 class 'mcmcr'",
    class = "chk_error"
  )
})
