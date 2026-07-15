test_that("coef simplify = FALSE is defunct", {
  lifecycle::expect_defunct(
    coef(as.mcmc.list(mcmcr_example), simplify = FALSE)
  )
  lifecycle::expect_defunct(
    coef(mcmcr_example, simplify = FALSE)
  )
  lifecycle::expect_defunct(
    coef(as.numeric(1:10), simplify = FALSE)
  )
})

test_that("coef.mcmc simplify = TRUE", {
  coef_mcmc.list <- coef(
    as.mcmc.list(mcmcr_example),
    directional_information = FALSE
  )
  expect_identical(
    colnames(coef_mcmc.list),
    c("term", "estimate", "lower", "upper", "svalue")
  )
  expect_identical(
    coef_mcmc.list$term,
    sort(as_term(c(
      "alpha[1]",
      "alpha[2]",
      "beta[1,1]",
      "beta[2,1]",
      "beta[1,2]",
      "beta[2,2]",
      "sigma"
    )))
  )

  coef_mcmcr <- coef(mcmcr_example, directional_information = FALSE)
  expect_identical(coef_mcmcr, coef_mcmc.list)

  coef_mcmcr2 <- coef(mcmcr_example2, directional_information = FALSE)
  expect_identical(
    colnames(coef_mcmcr2),
    c("term", "estimate", "lower", "upper", "svalue")
  )
  expect_identical(nrow(coef_mcmcr2), 11L)

  coef_mcmcarray <- coef(mcmcr_example$beta, directional_information = FALSE)
  expect_identical(
    colnames(coef_mcmc.list),
    c("term", "estimate", "lower", "upper", "svalue")
  )
  expect_identical(
    coef_mcmcarray$term,
    sort(as_term(c(
      "parameter[1,1]",
      "parameter[2,1]",
      "parameter[1,2]",
      "parameter[2,2]"
    )))
  )

  coef_mcarray <- coef(
    as.mcarray(mcmcr_example$beta),
    directional_information = FALSE
  )
  expect_identical(coef_mcarray, coef_mcmcarray)
})

test_that("coef directional_information = TRUE", {
  coef_di <- coef(mcmcr_example, directional_information = TRUE)
  expect_identical(
    colnames(coef_di),
    c("term", "estimate", "lower", "upper", "svalue")
  )

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

test_that("coef directional_information matches extras for all terms", {
  coef_di <- coef(mcmcr_example, directional_information = TRUE)
  mcmc <- as.mcmc(collapse_chains(as.mcmc.list(mcmcr_example)))
  expected <- apply(mcmc, 2, extras::directional_information)
  expected <- unname(expected[order(as_term(colnames(mcmc)))])
  expect_identical(coef_di$svalue, expected)

  coef_svalue <- coef(mcmcr_example, directional_information = FALSE)
  expect_false(identical(coef_di$svalue, coef_svalue$svalue))
})

test_that("coef directional_information consistent across classes", {
  coef_mcmcr <- coef(mcmcr_example, directional_information = TRUE)
  expect_identical(
    coef(as.mcmc.list(mcmcr_example), directional_information = TRUE),
    coef_mcmcr
  )

  coef_mcmcarray <- coef(mcmcr_example$beta, directional_information = TRUE)
  expect_identical(
    coef(as.mcarray(mcmcr_example$beta), directional_information = TRUE),
    coef_mcmcarray
  )
})

test_that("coef directional_information values", {
  # all values above the threshold: information capped at log2(n) bits
  x <- as.numeric(1:100)
  expect_equal(coef(x, directional_information = TRUE)$svalue, 6.64385619)

  # all values below the threshold: side = "median" uses the left side
  expect_equal(coef(-x, directional_information = TRUE)$svalue, 6.64385619)

  # equal numbers of values on each side: no directional information
  expect_identical(
    coef(c(-2, -1, 1, 2), directional_information = TRUE)$svalue,
    0
  )

  # 3:1 split: log2(3/4) - log2(1/4) = log2(3) bits
  expect_equal(
    coef(c(-1, 1, 2, 3), directional_information = TRUE)$svalue,
    log2(3)
  )

  # missing values propagate
  expect_identical(
    coef(c(1, NA), directional_information = TRUE)$svalue,
    NA_real_
  )
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
