context("test-team_1")

test_that("Function team_1 doesn't work.", {
  filename <- system.file("extdata", "gadm36_ISL_1.shp", package = "smoothMap")

  expect_error(team_1("gadm36_ISL_1.shx"))
  expect_error(team_1(filename, tolerance = "tol"))
  expect_error(team_1(filename, tolerance = -1))
  expect_error(team_1(filename, tolerance = Inf))

  dat <- team_1(filename, tolerance = 0.01)
  dat_head <- structure(list(GID_0 = "ISL", NAME_0 = "Iceland", GID_1 = "ISL.1_1",
                             NAME_1 = "Austurland", VARNAME_1 = "Eastland", NL_NAME_1 = NA_character_,
                             TYPE_1 = "Landsvæði", ENGTYPE_1 = "Region", CC_1 = NA_character_,
                             HASC_1 = "IS.AL", group = 1L, long = -12.05416679, lat = 63.09583282,
                             order = 1L), row.names = c(NA, -1L), class = c("tbl_df",
                                                                            "tbl", "data.frame"))
  expect_equivalent(head(dat, 1), dat_head)
})
