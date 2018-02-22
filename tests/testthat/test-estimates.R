context("estimates")

test_that("estimates", {
  mcmcr_example <- mcmcr_example
  expect_equal(estimates(mcmcr_example[[1]]), c(3.718025, 4.718025))
  expect_equal(estimates(mcmcr_example[[3]]), c(0.7911975))
  expect_identical(estimates(mcmcr_example)$alpha, estimates(mcmcr_example[[1]]))
})

test_that("estimates not as list", {
  expect_equal(estimates(mcmcr_example[[1]], as_df = TRUE), tibble::tibble(term = as.term(c("parameter[1]", "parameter[2]")), estimate = estimates(mcmcr_example[[1]])))
  expect_equal(estimates(mcmcr_example[[2]], as_df = TRUE), tibble::tibble(term = as.term(c("parameter[1,1]", "parameter[2,1]", "parameter[1,2]", "parameter[2,2]")), estimate = as.vector(estimates(mcmcr_example[[2]]))))
  expect_equivalent(estimates(mcmcr_example[[3]], as_df = TRUE), tibble::tibble(term = as.term("parameter"), estimate = estimates(mcmcr_example[[3]])))
  expect_identical(sort(estimates(mcmcr_example, as_df = TRUE)$term), sort(as.term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma"))))
})

test_that("estimates not as list", {
  expect_equal(estimates(mcmcr_example[[3]], fun = sum), 774.4415, tolerance = 0.0000001)
  expect_equal(estimates(mcmcr_example[[3]], fun = sum, as_df = TRUE)$estimate, 774.4415, tolerance = 0.0000001)
  expect_identical(estimates(mcmcr_example[[3]], fun = length), 800L)
  expect_identical(estimates(mcmcr_example[[3]], fun = length, as_df = TRUE)$estimate, 800L)
})
