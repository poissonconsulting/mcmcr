context("bind_dimensions")

test_that("bind_dimensions", {
  expect_identical(pdims(bind_dimensions(mcmcr_example$beta, mcmcr_example$beta)), c(2L,2L,2L))
  expect_identical(pdims(bind_dimensions(mcmcr_example, mcmcr_example)),
                   list(alpha = c(1L, 2L, 2L), beta = c(2L, 2L, 2L), sigma = c(1L, 2L)))
})
