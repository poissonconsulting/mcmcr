save_csv <- function(x) {
  path <- tempfile(fileext = ".csv")
  readr::write_csv(x, path)
  path
}

expect_snapshot_data <- function(x, name) {
  skip_on("windows")
  path <- save_csv(x)
  testthat::expect_snapshot_file(path, paste0(name, ".csv"))
}
