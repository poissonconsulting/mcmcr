test_that("bind_dimensions_n.mcmcarray", {
  expect_identical(bind_dimensions_n(mcmcr_example$beta), mcmcr_example$beta)
  expect_identical(pdims(bind_dimensions_n(mcmcr_example$beta, mcmcr_example$beta, mcmcr_example$beta)),
                   c(2L, 2L, 3L))
})

test_that("bind_dimensions_n.mcmcr", {
  expect_identical(bind_dimensions_n(mcmcr_example), mcmcr_example)
  expect_identical(pdims(bind_dimensions_n(mcmcr_example, mcmcr_example, mcmcr_example)),
                   list(alpha = c(2L, 3L), beta = c(2L, 2L, 3L), sigma = c(1L, 3L)))
})
