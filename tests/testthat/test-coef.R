context("coef")

test_that("coef", {
  mcmcr2 <- coef(mcmcr[[2]])
  expect_identical(colnames(mcmcr2), c("term", "estimate", "std.error", "statistic", "p.value", "lower", "upper"))
  expect_identical(mcmcr2$term, c("[1,1]", "[1,2]", "[2,1]", "[2,2]"))
})
