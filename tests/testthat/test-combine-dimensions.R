test_that("combine_dimensions.mcmcarray", {
  expect_identical(pdims(combine_dimensions(mcmcr_example$beta)), c(2L))
  expect_identical(
    pdims(combine_dimensions(mcmcr_example$beta, along = 1L)),
    c(2L)
  )
  expect_error(
    combine_dimensions(mcmcr_example$beta, along = 0L),
    "^`along` must be between 1 and 2, not 0[.]$",
    class = "chk_error"
  )
  expect_error(
    combine_dimensions(mcmcr_example$beta, along = 3L),
    "^`along` must be between 1 and 2, not 3[.]$",
    class = "chk_error"
  )
  expect_identical(pdims(combine_dimensions(mcmcr_example$alpha)), 1L)
  expect_identical(pdims(combine_dimensions(mcmcr_example$sigma)), 1L)
  expect_identical(
    pdims(combine_dimensions(mcmcr_example2$sigma, along = 1L)),
    c(1L, 1L)
  )
  expect_equal(
    combine_dimensions(bind_dimensions(
      mcmcr_example2$beta,
      mcmcr_example2$beta
    )),
    mcmcr_example2$beta,
    ignore_attr = FALSE
  )
})

test_that("combine_dimensions.mcmcr", {
  expect_equal(
    combine_dimensions(bind_dimensions_n(
      mcmcr_example,
      mcmcr_example,
      mcmcr_example
    )),
    mcmcr_example,
    ignore_attr = FALSE
  )
  expect_equal(
    combine_dimensions(bind_dimensions_n(
      mcmcr_example2,
      mcmcr_example2,
      mcmcr_example2
    )),
    mcmcr_example2,
    ignore_attr = FALSE
  )
})

test_that("combine_dimensions.mcmcr accepts along of length 1 or npars", {
  expect_identical(
    pdims(combine_dimensions(mcmcr_example, along = 1L)),
    list(alpha = 1L, beta = 2L, sigma = 1L)
  )
  expect_identical(
    pdims(combine_dimensions(mcmcr_example, along = c(1L, 2L, 1L))),
    list(alpha = 1L, beta = 2L, sigma = 1L)
  )
  expect_error(
    combine_dimensions(mcmcr_example, along = c(1L, 2L)),
    "^`length\\(along\\)` must match 1 or 3",
    class = "chk_error"
  )
})
