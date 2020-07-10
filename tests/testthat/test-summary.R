test_that("summary.mcmcarray", {
  expect_equal(
    summary(mcmcr_example$alpha),
    structure(list(
      estimates = c(3.718025, 4.718025), nchains = 2L,
      niters = 400L
    ), class = "summary.mcmcarray")
  )
})

test_that("summary.mcmcr", {
  expect_is(summary(mcmcr_example), "summary.mcmcr")
})
