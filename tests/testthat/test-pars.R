context("pars")

test_that("pars.term", {
  term <- term(mcmcr_example)
  expect_identical(pars(term), c("alpha", "beta", "sigma"))
  expect_identical(pars(term, scalar_only = TRUE), "sigma")
  expect_identical(pars(term, scalar_only = TRUE, terms = TRUE), "sigma")
  expect_identical(pars(term, terms = TRUE),
                   c("alpha", "alpha", "beta",  "beta",  "beta",  "beta",  "sigma"))

  expect_identical(set_pars(term, pars = c("gamma", "theta", "rho")),
                                  as.term(c("gamma[1]", "gamma[2]", "theta[1,1]", "theta[2,1]", "theta[1,2]", "theta[2,2]", "rho")))

})

test_that("pars.mcmcr", {
  expect_equal(pars(mcmcr_example), c("alpha", "beta", "sigma"))
  expect_equal(pars(mcmcr_example, scalar_only = TRUE), c("sigma"))
  pars(mcmcr_example) <- c("alpha1", "alpha2", "alpha3")
  expect_equal(pars(mcmcr_example), c("alpha1", "alpha2", "alpha3"))
})

test_that("pars.mcmcrs", {
  mcmcrs <- mcmcrs(mcmcr::mcmcr_example, mcmcr::mcmcr_example)
  expect_equal(pars(mcmcrs), c("alpha", "beta", "sigma"))
  expect_equal(pars(mcmcrs, scalar_only = TRUE), c("sigma"))
  pars(mcmcrs) <- c("alpha1", "alpha2", "alpha3")
  expect_equal(pars(mcmcrs), c("alpha1", "alpha2", "alpha3"))
})
