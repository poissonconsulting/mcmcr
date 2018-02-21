context("term")

test_that("term", {
  x <- c("parm3[10]", "parm3[2]", "parm[2,2]", "parm[1,1]", "parm[2,1]", "parm[1,2]", "parm[10]", "parm3")
  x2 <- as.term(x)
  expect_is(x2, "term")
  expect_true(is.term(x2))
  x3 <- as.character(x2)
  expect_identical(x, x3)

  expect_identical(parameters(x2, terms = TRUE), c(rep("parm3", 2), rep("parm", 5), "parm3"))
  expect_identical(dims_terms(x2), list(10L, 2L, c(2L,2L), c(1L,1L), c(2L,1L), c(1L,2L), 10L, 1L))
  expect_identical(x2 > x2, rep(FALSE, length(x2)))

  expect_identical(sort(x2), as.term(c("parm[10]", "parm[1,1]", "parm[2,1]", "parm[1,2]",
                                       "parm[2,2]", "parm3", "parm3[2]", "parm3[10]")))
})

test_that("terms.mcmcarray", {
  expect_identical(as.term(mcmcr_example[[1]]), as.term(c("parameter[1]", "parameter[2]")))
  expect_identical(as.term(mcmcr_example[[2]]), as.term(c("parameter[1,1]", "parameter[2,1]", "parameter[1,2]", "parameter[2,2]")))
  expect_identical(as.term(mcmcr_example[[3]]), as.term("parameter"))
})

test_that("terms.mcmcr", {
  expect_identical(terms(mcmcr_example), as.term(c("alpha[1]", "alpha[2]", "beta[1,1]", "beta[2,1]", "beta[1,2]", "beta[2,2]", "sigma" )))
  expect_identical(length(terms(mcmcr_example2)), 11L)
})

