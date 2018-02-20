context("pdims")

test_that("pdims.term", {
  expect_identical(pdims(as.term(c("gamma[1]", "gamma[2]", "theta[1,1]", "theta[2,1]", "theta[1,2]", "theta[2,2]", "rho")))


                           pdims(terms(mcmcr_example))

                   , c("alpha", "beta", "sigma"))
  expect_identical(parameters(terms, scalar_only = TRUE), "sigma")
  expect_identical(parameters(terms, scalar_only = TRUE, terms = TRUE), "sigma")
  expect_identical(parameters(terms, terms = TRUE),
                   c("alpha", "alpha", "beta",  "beta",  "beta",  "beta",  "sigma"))

  expect_identical(set_parameters(terms, parameters = c("gamma", "theta", "rho")),
                                  ))

})
