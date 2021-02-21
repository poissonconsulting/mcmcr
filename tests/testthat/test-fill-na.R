test_that("fill_na.mcarray", {
  mcarray <- as.mcarray(mcmcr_example[[2]])
  mcarray <- fill_all(mcarray, NA_real_)
  expect_equal(estimates(fill_na(mcarray, 1)), matrix(1, nrow = 2, ncol = 2), check.attributes = FALSE)
})

test_that("fill_na.mcmcarray", {
  mcmcarray <- mcmcr_example[[2]]
  mcmcarray <- fill_all(mcmcarray, NA_real_)
  expect_equal(estimates(fill_na(mcmcarray, 2)), matrix(2, nrow = 2, ncol = 2), check.attributes = FALSE)
})
#
# test_that("fill_na.mcmcr", {
#   mcmcr0 <- fill_na(mcmcr_example, pars = "sigma")
#   expect_identical(estimates(mcmcr0)$sigma, 0)
#   expect_identical(estimates(mcmcr0)$beta, estimates(mcmcr_example)$beta)
# })

test_that("fill_na.mcmcr", {
  mcmcr0 <- fill_na(mcmcr_example)
  mcmcr0 <- fill_all(mcmcr0, NA_real_)
  mcmcr0 <- fill_na(mcmcr0, 10.1)
  expect_equal(estimates(mcmcr0)$sigma, 10.1)
  expect_equal(estimates(mcmcr0)$beta, matrix(10.1, 2, 2))
})
