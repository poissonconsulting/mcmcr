context("as")

test_that("as.term", {
  term <- as.term(coda::as.mcmc.list(mcmcr_example))
  expect_identical(term,
                   structure(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]",
                               "beta[1,2]", "beta[2,2]", "sigma"), class = c("term", "character"
                               )))
})
