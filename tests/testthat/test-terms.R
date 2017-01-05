context("terms")

test_that("terms.mcmcarray", {
  expect_identical(terms(mcmcr[[1]]), c("[1]", "[2]"))
  expect_identical(terms(mcmcr[[2]]), c("[1,1]", "[2,1]", "[1,2]", "[2,2]"))
  expect_identical(terms(mcmcr[[3]]), "")
})

test_that("terms.mcmcr", {
  expect_identical(terms(mcmcr), c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma" ))
})
