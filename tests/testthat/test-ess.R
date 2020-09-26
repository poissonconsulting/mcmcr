test_that("ess.mcmcmarray", {
  expect_identical(ess(mcmcr_example[[1]], by = "term"), c(9L, 9L))
  expect_equivalent(ess(mcmcr_example[[2]], by = "term"), matrix(c(40L, 40L, 40L, 40L), nrow = 2))
  expect_identical(ess(mcmcr_example[[3]], by = "term"), c(378L))
  expect_identical(ess(mcmcr_example[[2]]), 40L)
  expect_identical(ess(mcmcr_example[[1]], "parameter"), ess(mcmcr_example[[1]], "all"))
})

test_that("ess.mcmcr", {
  expect_identical(ess(mcmcr_example2), 9L)
  expect_identical(ess(mcmcr_example), 9L)
  expect_identical(ess(mcmcr_example, by = "parameter"), list(alpha = 9L, beta = 40L, sigma = 378L))
})

test_that("ess.mcmcr as df", {
  expect_identical(
    ess(mcmcr_example, as_df = TRUE),
    structure(list(all = "all", ess = 9L), row.names = c(NA, -1L), class = c(
      "tbl_df",
      "tbl", "data.frame"
    ))
  )
  skip_if(packageVersion("testthat") < '2.99.0.9000')

  expect_identical(ess(mcmcr_example, as_df = TRUE, by = "parameter"),
                   tibble::tibble(parameter = c("alpha", "beta", "sigma"),
                                   ess = c(9L, 40L, 378L)))
})

test_that("ess.mcmcrs", {
  expect_identical(ess(mcmcrs(mcmcr_example), by = "parameter")[[1]], list(alpha = 9L, beta = 40L, sigma = 378L))
})
