test_that("coef.mcmc", {
  rlang::local_options(lifecycle_verbosity = "quiet")

  coef_mcmc.list <- coef(as.mcmc.list(mcmcr_example), simplify = FALSE)
  expect_identical(colnames(coef_mcmc.list), c("term", "estimate", "sd", "zscore", "lower", "upper", "pvalue"))
  expect_identical(coef_mcmc.list$term, sort(as_term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma"))))
})

test_that("coef.mcmc simplify = TRUE", {
  coef_mcmc.list <- coef(as.mcmc.list(mcmcr_example), directional_information = FALSE)
  expect_identical(colnames(coef_mcmc.list), c("term", "estimate", "lower", "upper", "svalue"))
  expect_identical(coef_mcmc.list$term, sort(as_term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma"))))

  coef_mcmcr <- coef(mcmcr_example, directional_information = FALSE)
  expect_identical(coef_mcmcr, coef_mcmc.list)

  coef_mcmcr2 <- coef(mcmcr_example2, directional_information = FALSE)
  expect_identical(colnames(coef_mcmcr2), c("term", "estimate", "lower", "upper", "svalue"))
  expect_identical(nrow(coef_mcmcr2), 11L)

  coef_mcmcarray <- coef(mcmcr_example$beta, directional_information = FALSE)
  expect_identical(colnames(coef_mcmc.list), c("term", "estimate", "lower", "upper", "svalue"))
  expect_identical(coef_mcmcarray$term, sort(as_term(c("parameter[1,1]", "parameter[2,1]", "parameter[1,2]", "parameter[2,2]"))))

  coef_mcarray <- coef(as.mcarray(mcmcr_example$beta), directional_information = FALSE)
  expect_identical(coef_mcarray, coef_mcmcarray)
})

test_that("coef directional_information = TRUE", {
  coef_di <- coef(mcmcr_example, directional_information = TRUE)
  expect_identical(colnames(coef_di), c("term", "estimate", "lower", "upper", "svalue"))

  coef_svalue <- coef(mcmcr_example, directional_information = FALSE)
  expect_identical(
    coef_di[c("term", "estimate", "lower", "upper")],
    coef_svalue[c("term", "estimate", "lower", "upper")]
  )

  samples <- as.vector(collapse_chains(mcmcr_example)$sigma)
  expect_identical(
    coef_di$svalue[coef_di$term == "sigma"],
    extras::directional_information(samples)
  )
  expect_identical(
    coef_svalue$svalue[coef_svalue$term == "sigma"],
    extras::svalue(samples)
  )
})

test_that("coef.numeric directional_information = TRUE", {
  x <- as.numeric(-10:100)
  coef_di <- coef(x, directional_information = TRUE)
  expect_identical(colnames(coef_di), c("estimate", "lower", "upper", "svalue"))
  expect_identical(coef_di$svalue, extras::directional_information(x))
})

test_that("coef soft-deprecates unset directional_information", {
  lifecycle::expect_deprecated(coef(mcmcr_example))
  lifecycle::expect_deprecated(coef(as.mcmc.list(mcmcr_example)))
  lifecycle::expect_deprecated(coef(mcmcr_example$beta))
  lifecycle::expect_deprecated(coef(as.numeric(1:10)))

  expect_no_warning(coef(mcmcr_example, directional_information = FALSE))
  expect_no_warning(coef(mcmcr_example, directional_information = TRUE))
})

test_that("coef.mcmc errors chk directional_information", {
  chk::expect_chk_error(coef(mcmcr_example, directional_information = NA))
})
