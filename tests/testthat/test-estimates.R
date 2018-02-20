context("estimates")

test_that("estimates", {
  mcmcr_example <- mcmcr::mcmcr_example
  expect_equal(estimates(mcmcr_example[[1]]), c(2.998247, 3.998247))
  expect_equal(estimates(mcmcr_example[[3]]), c(0.7911975))
  expect_identical(estimates(mcmcr_example)$alpha, estimates(mcmcr_example[[1]]))
})

test_that("estimates not as list", {
  expect_equal(estimates(mcmcr[[1]], as_list = FALSE), tibble::tibble(term = as.term(c("[1]", "[2]")), estimate = estimates(mcmcr[[1]])))
  expect_equal(estimates(mcmcr[[2]], as_list = FALSE), tibble::tibble(term = as.term(c("[1,1]", "[2,1]", "[1,2]", "[2,2]")), estimate = as.vector(estimates(mcmcr[[2]]))))
  expect_equivalent(estimates(mcmcr[[3]], as_list = FALSE), tibble::tibble(term = as.term(""), estimate = estimates(mcmcr[[3]])))
  expect_identical(sort(estimates(mcmcr, as_list = FALSE)$term), sort(as.term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma"))))
})
