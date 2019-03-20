context("test-team_2")

test_that("Function team_2 doesn't work.", {
  library(dplyr)
  file <- system.file("extdata", "gadm36_CUB_1.shp", package = "smoothMap")
  file2 <- system.file("extdata", "gadm36_CUB_1.shx", package = "smoothMap")
  dat <- team_2(file, tolerance = 0.01)
  expect_error(team_2(file2, tolerance = 0.01)) # not a shape file
  expect_error(team_2(file, tolerance = "A")) # tolerance is not a number
  expect_error(team_2(file, tolerance = -0.01)) #tolerance is negative
  expect_warning(team_2(file, tolerance = 2)) # tolerance is very high
  expect_s3_class(dat, "data.frame")
})
