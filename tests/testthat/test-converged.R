test_that("converged.mcmcr", {
  expect_false(converged(mcmcr_example))
  expect_false(converged(mcmcr_example, rhat = 2.1))
  expect_true(converged(mcmcr_example, rhat = 2.1, esr = 0))

  expect_identical(
    converged(mcmcr_example, by = "parameter"),
    list(alpha = FALSE, beta = FALSE, sigma = TRUE)
  )

  expect_identical(
    converged(mcmcr_example, by = "parameter", as_df = TRUE),
    tibble::tibble(parameter = c("alpha", "beta", "sigma"),
      converged = c(FALSE, FALSE, TRUE)
      )
  )

  expect_identical(
    converged(mcmcr_example, by = "term"),
    list(
      alpha = c(FALSE, FALSE),
      beta = structure(c(
        FALSE, FALSE,
        FALSE, FALSE
      ), .Dim = c(2L, 2L)),
      sigma = TRUE
    )
  )

  expect_identical(
    converged(mcmcr_example, as_df = TRUE),
    structure(list(all = "all", converged = FALSE),
      row.names = c(NA, -1L),
      class = c("tbl_df", "tbl", "data.frame")
    )
  )
})

test_that("converged.mcmcarray", {
  expect_true(converged(mcmcr_example$sigma))
})

test_that("converged.mcmcrs", {
  mcmcrs <- as.mcmcrs(list(mcmcr_example, mcmcr_example))
  expect_identical(converged(mcmcrs), list(mcmcr1 = FALSE, mcmcr2 = FALSE))
  expect_identical(
    converged(mcmcrs, by = "parameter"),
    list(
      mcmcr1 = list(alpha = FALSE, beta = FALSE, sigma = TRUE),
      mcmcr2 = list(alpha = FALSE, beta = FALSE, sigma = TRUE)
    )
  )
  expect_false(converged(mcmcrs, bound = TRUE), FALSE)
  expect_identical(
    converged(mcmcrs, bound = TRUE, by = "parameter"),
    list(alpha = FALSE, beta = FALSE, sigma = TRUE)
  )
})
