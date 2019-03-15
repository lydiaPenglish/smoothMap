context("test-team_4")

test_that("team_4 function works", {
  library(dplyr)
  file <- system.file("extdata", "gadm36_PAN_1.shp", package = "smoothMap")
  file2 <- system.file("extdata", "gadm36_PAN_1.shx", package = "smoothMap")
  dat <- team_4(file, tolerance = 0.01)
  expect_error(team_4(file2, tolerance = 0.01)) # not a shape file
  expect_error(team_4(file, tolerance = "A")) # tolerance is not a number
  expect_error(team_4(file, tolerance = -0.01)) #tolerance is negative
  expect_warning(team_4(file, tolerance = 2)) # tolerance is very high
  expect_s3_class(dat, "data.frame")
  expect_named(dat, c("GID_0", "NAME_0", "GID_1", "NAME_1", "VARNAME_1", "NL_NAME_1", "TYPE_1",
                      "ENGTYPE_1", "CC_1", "HASC_1", "group", "long", "lat", "order"),
               ignore.order = TRUE, ignore.case = TRUE)
})


