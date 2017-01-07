context("coef")

test_that("coef.mcmcmarray", {
  mcmcr1 <- coef(mcmcr[[1]])
  mcmcr2 <- coef(mcmcr[[2]])
  mcmcr3 <- coef(mcmcr[[3]])
  expect_identical(colnames(mcmcr2), c("term", "estimate", "sd", "zscore", "lower", "upper", "significance"))
  expect_identical(mcmcr1$term, c("[1]", "[2]"))
  expect_identical(mcmcr2$term, c("[1,1]", "[1,2]", "[2,1]", "[2,2]"))
  expect_identical(mcmcr3$term, "")
})

test_that("coef.mcmcr", {
  coef <- coef(mcmcr)
  expect_identical(colnames(coef), c("term", "estimate", "sd", "zscore", "lower", "upper", "significance"))
  expect_identical(coef$term, c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[1,2]", "beta[2,1]", "beta[2,2]", "sigma"))
})
