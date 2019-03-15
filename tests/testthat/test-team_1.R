context("test-team_1")

test_that("Function team_1 doesn't work.", {
  filename <- system.file("extdata", "gadm36_MEX_1.shp", package = "smoothMap")

  expect_error(team_1("gadm36_MEX_1.shx"))
  expect_error(team_1(filename, tolerance = "tol"))
  expect_error(team_1(filename, tolerance = -1))
  expect_error(team_1(filename, tolerance = Inf))

  dat <- team_1(filename, tolerance = 0.1)
  dat_head <- structure(list(GID_0 = "MEX", NAME_0 = "Mexico", GID_1 = "MEX.1_1",
                             NAME_1 = "Aguascalientes", VARNAME_1 = NA_character_, NL_NAME_1 = NA_character_,
                             TYPE_1 = "Estado", ENGTYPE_1 = "State", CC_1 = NA_character_,
                             HASC_1 = "MX.AG", group = 1L, long = -102.44799042, lat = 21.66107178,
                             order = 1L), row.names = c(NA, -1L), class = c("tbl_df", "tbl", "data.frame"))
  expect_equivalent(head(dat, 1), dat_head)
})
