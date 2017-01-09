context("derive")

test_that("derive", {

  mcmcr <- subset(mcmcr, 1:2, 1:10)

  derived <- derive(mcmcr, "gamma <- alpha + beta")
  expect_identical(parameters(derived), "gamma")
  expect_identical(nchains(derived), 2L)
  expect_identical(niters(derived), 10L)
  expect_identical(nterms(derived), 4L)
})

test_that("derive", {

  mcmcr <- subset(mcmcr, 1:2, 1:10)

  expr <- "
    gamma <- alpha + beta
  alpha2 <- alpha * 2
  znot <- alpha * 2
  for(i in seq_along(x)) {
    alpha3[i] <- alpha[1] * x[i]
  }
  "

  values <- list(x = 2:10)

  derived <- derive(mcmcr, expr, values = values, monitor = "^g|^a")

  expect_identical(parameters(derived), c("alpha2", "alpha3", "gamma"))
  expect_identical(nchains(derived), 2L)
  expect_identical(niters(derived), 10L)
  expect_identical(nterms(derived), 15L)

  quick <- derive(mcmcr, expr, values = values, monitor = "^g|^a", quick = TRUE)

  expect_identical(nchains(quick), 1L)
  expect_identical(niters(quick), 1L)

  expect_equal(estimates(quick), estimates(derived), tolerance = 0.01, check.attributes = FALSE)
})
