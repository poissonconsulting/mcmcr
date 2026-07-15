test_that("tidy.mcmcr", {
  x <- subset(mcmcr::mcmcr_example, iters = 1:2)
  expect_identical(
    tidy(x, simplify = TRUE, directional_information = FALSE),
    tidy(
      nlist::as_mcmc_list(x),
      simplify = TRUE,
      directional_information = FALSE
    )
  )
  expect_identical(
    tidy(x, simplify = TRUE, directional_information = TRUE),
    tidy(
      nlist::as_mcmc_list(x),
      simplify = TRUE,
      directional_information = TRUE
    )
  )
})

test_that("tidy soft-deprecates unset directional_information", {
  x <- subset(mcmcr::mcmcr_example, iters = 1:2)
  lifecycle::expect_deprecated(tidy(x, simplify = TRUE))
  expect_no_warning(tidy(x, simplify = TRUE, directional_information = FALSE))
  expect_no_warning(tidy(x, simplify = TRUE, directional_information = TRUE))
})
