context("converged")

test_that("converged.mcmcr", {
  expect_false(converged(mcmcr_example))
  expect_false(converged(mcmcr_example2))
})

test_that("converged.mcmcarray", {
  expect_true(converged(mcmcr_example$sigma))
})

test_that("converged.mcmcrs", {
  expect_identical(converged(as.mcmcrs(list(mcmcr_example, mcmcr_example))),
                   list(mcmcr1 = FALSE, mcmcr2 = FALSE))
#  expect_identical(converged(as.mcmcrs(list(mcmcr_example, mcmcr_example)), as_df = TRUE),
#                   list(mcmcr1 = FALSE, mcmcr2 = FALSE))
})
