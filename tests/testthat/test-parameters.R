context("parameters")

test_that("parameters.term", {
  terms <- terms(mcmcr_example)
  expect_identical(parameters(terms), c("alpha", "beta", "sigma"))
  expect_identical(parameters(terms, scalar_only = TRUE), "sigma")
  expect_identical(parameters(terms, scalar_only = TRUE, terms = TRUE), "sigma")
  expect_identical(parameters(terms, terms = TRUE),
                   c("alpha", "alpha", "beta",  "beta",  "beta",  "beta",  "sigma"))

  expect_identical(set_parameters(terms, parameters = c("gamma", "theta", "rho")),
                                  as.term(c("gamma[1]", "gamma[2]", "theta[1,1]", "theta[2,1]", "theta[1,2]", "theta[2,2]", "rho")))

})

test_that("parameters.mcmcr", {
  expect_equal(parameters(mcmcr_example), c("alpha", "beta", "sigma"))
  expect_equal(parameters(mcmcr_example, scalar_only = TRUE), c("sigma"))
  parameters(mcmcr_example) <- c("alpha1", "alpha2", "alpha3")
  expect_equal(parameters(mcmcr_example), c("alpha1", "alpha2", "alpha3"))
})
