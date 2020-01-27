context("fill-all")

test_that("fill_all.mcarray", {
  mcarray <- as.mcarray(mcmcr_example[[2]])
  expect_equal(estimates(fill_all(mcarray)), matrix(0, nrow = 2, ncol = 2), check.attributes = FALSE)
})

test_that("fill_all.mcmcarray", {
  mcmcarray <- mcmcr_example[[2]]
  expect_equal(estimates(fill_all(mcmcarray)), matrix(0, nrow = 2, ncol = 2), check.attributes = FALSE)
})
#
# test_that("fill_all.mcmcr", {
#   mcmcr0 <- fill_all(mcmcr_example, pars = "sigma")
#   expect_identical(estimates(mcmcr0)$sigma, 0)
#   expect_identical(estimates(mcmcr0)$beta, estimates(mcmcr_example)$beta)
# })

test_that("fill_all.mcmcr", {
  mcmcr0 <- fill_all(mcmcr_example)
  expect_identical(estimates(mcmcr0)$sigma, 0)
  expect_identical(estimates(mcmcr0)$beta, matrix(0, 2, 2))
})
