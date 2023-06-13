test_that("ess.mcmcmarray", {
  expect_identical(ess(mcmcr_example[[1]], by = "term"), c(9L, 9L))
  expect_equal(ess(mcmcr_example[[2]], by = "term"), matrix(c(40L, 40L, 40L, 40L), nrow = 2))
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
  expect_snapshot_data(ess(mcmcr_example, as_df = TRUE, by = "parameter"),
                       "ess")
})

test_that("ess.mcmcr constant", {
  x <- mcmcr::mcmcr_example
  x$sigma[,,1] <- 0

  expect_identical(ess(x$sigma), 800L)
  expect_identical(ess(x), 9L)
})

test_that("ess.mcmcrs", {
  expect_identical(ess(mcmcrs(mcmcr_example), by = "parameter")[[1]], list(alpha = 9L, beta = 40L, sigma = 378L))
})
