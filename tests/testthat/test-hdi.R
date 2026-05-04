test_that("hdi() returns the correct values.", {
  expect_equal(hdi(NA_real_), data.frame(lower = NA_real_, upper = NA_real_))
  expect_equal(hdi(numeric(0)), data.frame(lower = NA_real_, upper = NA_real_))
  expect_equal(hdi(NA_integer_), data.frame(lower = NA_real_, upper = NA_real_))
  expect_equal(hdi(c(0, rep(Inf, 19))), data.frame(lower = Inf, upper = Inf))
  expect_equal(hdi(c(0, rep(-Inf, 19))), data.frame(lower = -Inf, upper = -Inf))
  expect_equal(hdi(1:100), data.frame(lower = 3, upper = 98))
  expect_equal(hdi(seq(0, 1, length.out = 1e3)),
               data.frame(lower = 0.032032032032032, upper = 0.982982982982983))
  expect_equal(hdi(c(1:100, Inf)), data.frame(lower = 2, upper = 98))
  expect_equal(hdi(c(1:100, rep(Inf, 200))), data.frame(lower = 8, upper = Inf))

})

test_that("hdi() returns the correct warnings.", {
  expect_warning(hdi(1, warn = TRUE), "`length\\(x\\)` is too small to return a meaningful 95% CI. Returning NAs.")
  expect_warning(hdi(1:19, warn = TRUE), "`length\\(x\\)` is too small to return a meaningful 95% CI. Returning NAs.")
  expect_warning(hdi(rep(Inf, 1e3), warn = TRUE), "Found too many infite values to produce useful CIs. Returning Inf.")
  expect_warning(hdi(rep(1, 100), warn = TRUE), "Found 5 intervals with the same width. Returning the centermost interval of the set.")

  expect_no_warning(hdi(1, warn = FALSE))
  expect_no_warning(hdi(1:19, warn = FALSE))
  expect_no_warning(hdi(rep(Inf, 1e3), warn = FALSE))
  expect_no_warning(hdi(rep(1, 100), warn = FALSE))
})

