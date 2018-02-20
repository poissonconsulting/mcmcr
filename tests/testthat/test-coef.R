context("coef")

test_that("coef.mcmc", {
  coef_mcmc.list <- coef(coda::as.mcmc.list(mcmcr::mcmcr_example))
  expect_identical(colnames(coef_mcmc.list), c("term", "estimate", "sd", "zscore", "lower", "upper", "pvalue"))
  expect_identical(coef_mcmc.list$term, sort(as.term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma"))))

  coef_mcmcr <- coef(mcmcr::mcmcr_example)
  expect_identical(coef_mcmcr, coef_mcmc.list)

  coef_mcmcarray <- coef(mcmcr::mcmcr_example$beta)
  expect_identical(colnames(coef_mcmc.list), c("term", "estimate", "sd", "zscore", "lower", "upper", "pvalue"))
  expect_identical(coef_mcmcarray$term, sort(as.term(c("parameter[1,1]", "parameter[2,1]", "parameter[1,2]", "parameter[2,2]"))))

  coef_mcarray <- coef(as.mcarray(mcmcr::mcmcr_example$beta))
  expect_identical(coef_mcarray, coef_mcmcarray)
})
