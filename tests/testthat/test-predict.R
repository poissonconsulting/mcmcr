context("predict")

test_that("predict", {

  mcmcr <- subset(mcmcr, 1:2, 1:10)

  prediction <- predict(mcmcr, "gamma <- alpha + beta")
  expect_identical(parameters(prediction), "gamma")
  expect_identical(nchains(prediction), 2L)
  expect_identical(niters(prediction), 10L)
  expect_identical(nterms(prediction), 4L)
})

test_that("predict", {

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

  prediction <- predict(mcmcr, expr, values = values, monitor = "^g|^a")

  expect_identical(parameters(prediction), c("alpha2", "alpha3", "gamma"))
  expect_identical(nchains(prediction), 2L)
  expect_identical(niters(prediction), 10L)
  expect_identical(nterms(prediction), 15L)

  quick <- predict(mcmcr, expr, values = values, monitor = "^g|^a", quick = TRUE)

  expect_identical(nchains(quick), 1L)
  expect_identical(niters(quick), 1L)

  expect_equal(estimates(quick), estimates(prediction), tolerance = 0.01, check.attributes = FALSE)
})
