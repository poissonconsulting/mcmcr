test_that("as_term", {
  term <- as_term(mcmcr_example)
  expect_identical(term, term::new_term(c(
    "alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]",
    "beta[1,2]", "beta[2,2]", "sigma"
  )))
})

test_that("as.term", {
  rlang::local_options(lifecycle_verbosity = "quiet")
  term <- as_term(mcmcr_example)
  expect_identical(term, term::new_term(c(
    "alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]",
    "beta[1,2]", "beta[2,2]", "sigma"
  )))
})
