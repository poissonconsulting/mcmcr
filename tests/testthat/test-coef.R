context("coef")

test_that("coef.mcmcmarray", {
  mcmcr1 <- coef(mcmcr[[1]])
  mcmcr2 <- coef(mcmcr[[2]])
  mcmcr3 <- coef(mcmcr[[3]])
  expect_identical(colnames(mcmcr2), c("term", "estimate", "sd", "zscore", "lower", "upper", "pvalue"))
  expect_identical(mcmcr1$term, as.term(c("[1]", "[2]")))
  expect_identical(mcmcr2$term, as.term(c("[1,1]", "[2,1]", "[1,2]", "[2,2]")))
  expect_identical(mcmcr3$term, as.term(""))
})

test_that("coef.mcmcr", {
  coef <- coef(mcmcr)
  expect_identical(colnames(coef), c("term", "estimate", "sd", "zscore", "lower", "upper", "pvalue"))
  expect_identical(coef$term, as.term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma")))
})

test_that("missing limits iters", {
  mcmc <- mcmcr
  mcmc <- subset(mcmc, chains = 1L)
  coef <- coef(mcmc)
  expect_true(all(coef$lower < coef$estimate))

  mcmc <- subset(mcmc, iterations = 1:2)
  coef <- coef(mcmc)
  expect_true(all(coef$lower < coef$estimate))

  mcmc <- subset(mcmc, iterations = 1L)
  coef <- coef(mcmc)
  expect_true(all(is.na(coef$lower)))
})

test_that("missing limits chains", {
  mcmcr <- subset(mcmcr, iterations = 1L)
  coef <- coef(mcmcr)
  expect_true(all(coef$lower < coef$estimate))

  mcmcr <- subset(mcmcr, chains = 1:2)
  coef <- coef(mcmcr)
  expect_true(all(coef$lower < coef$estimate))

  mcmcr <- subset(mcmcr, chains = 1L)
  coef <- coef(mcmcr)
  expect_true(all(is.na(coef$lower)))
})

