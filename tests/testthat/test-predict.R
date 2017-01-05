context("predict")

test_that("predict.mcmcarray", {

 mcmcr <- subset(mcmcr, 1:2, 1:10)

 gamma <- predict(mcmcr, "gamma <- alpha + beta")
 expect_identical(parameters(gamma), "gamma")
 expect_identical(nchains(gamma), 2L)
 expect_identical(niters(gamma), 10L)

})
