context("bind_dimensions")

test_that("bind_dimensions", {
  expect_identical(pdims(bind_dimensions(mcmcr_example$beta, mcmcr_example$beta)), c(2L,2L,2L))
  expect_identical(pdims(bind_dimensions(mcmcr_example, mcmcr_example)),
                   list(alpha = c(2L, 2L), beta = c(2L, 2L, 2L), sigma = c(1L, 2L)))

  expect_identical(pdims(bind_dimensions(mcmcr_example2, mcmcr_example2)),
                   list(alpha = c(2L, 1L, 1L, 2L), beta = c(2L, 2L, 2L, 2L), sigma = c(1L, 1L, 1L, 2L)))

})

test_that("bind_dimensions_n", {
  expect_identical(pdims(bind_dimensions_n(mcmcr_example, mcmcr_example, mcmcr_example)),
                   list(alpha = c(2L, 3L), beta = c(2L, 2L, 3L), sigma = c(1L, 3L)))
})
