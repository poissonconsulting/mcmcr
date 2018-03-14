context("combine_dimensions")

test_that("combine_dimensions.mcmcarray", {
  expect_identical(pdims(combine_dimensions(mcmcr_example$beta)), c(2L))
  expect_identical(pdims(combine_dimensions(mcmcr_example$beta, along = 1L)), c(2L))
  expect_error(combine_dimensions(mcmcr_example$beta, along = 0L), "along must be NULL OR the values in along must lie between 1 and 2")
  expect_error(combine_dimensions(mcmcr_example$beta, along = 3L), "along must be NULL OR the values in along must lie between 1 and 2")
  expect_identical(pdims(combine_dimensions(mcmcr_example$alpha)), 1L)
  expect_identical(pdims(combine_dimensions(mcmcr_example$sigma)), 1L)
  expect_identical(pdims(combine_dimensions(mcmcr_example2$sigma, along = 1L)), c(1L, 1L))
  expect_equal(combine_dimensions(bind_dimensions(mcmcr_example2$beta, mcmcr_example2$beta)), mcmcr_example2$beta, check.attributes = FALSE)
})

test_that("combine_dimensions.mcmcr", {
  expect_equal(combine_dimensions(bind_dimensions_n(mcmcr_example, mcmcr_example, mcmcr_example)),
               mcmcr_example, check.attributes = FALSE)
  expect_equal(combine_dimensions(bind_dimensions_n(mcmcr_example2, mcmcr_example2, mcmcr_example2)),
               mcmcr_example2, check.attributes = FALSE)
})
