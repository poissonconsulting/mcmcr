test_that("coef.mcmc", {
  rlang::local_options(lifecycle_verbosity = "quiet")

  coef_mcmc.list <- coef(as.mcmc.list(mcmcr_example), simplify = FALSE)
  expect_identical(colnames(coef_mcmc.list), c("term", "estimate", "sd", "zscore", "lower", "upper", "pvalue"))
  expect_identical(coef_mcmc.list$term, sort(as_term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma"))))

})

test_that("coef.mcmc simplify = TRUE", {
  coef_mcmc.list <- coef(as.mcmc.list(mcmcr_example))
  expect_identical(colnames(coef_mcmc.list), c("term", "estimate", "lower", "upper", "svalue"))
  expect_identical(coef_mcmc.list$term, sort(as_term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma"))))

  coef_mcmcr <- coef(mcmcr_example)
  expect_identical(coef_mcmcr, coef_mcmc.list)

  coef_mcmcr2 <- coef(mcmcr_example2)
  expect_identical(colnames(coef_mcmcr2), c("term", "estimate", "lower", "upper", "svalue"))
  expect_identical(nrow(coef_mcmcr2), 11L)

  coef_mcmcarray <- coef(mcmcr_example$beta)
  expect_identical(colnames(coef_mcmc.list), c("term", "estimate", "lower", "upper", "svalue"))
  expect_identical(coef_mcmcarray$term, sort(as_term(c("parameter[1,1]", "parameter[2,1]", "parameter[1,2]", "parameter[2,2]"))))

  coef_mcarray <- coef(as.mcarray(mcmcr_example$beta))
  expect_identical(coef_mcarray, coef_mcmcarray)
})

