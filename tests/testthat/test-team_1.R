context("test-team_1")

test_that("Function team_1 doesn't work.", {
  set.seed(1)
  filename <- system.file("extdata", "gadm36_AUS_1.shp", package = "smoothMap")
  dat <- team_1(filename, tolerance = 0.1)

  expect_s3_class(dat, "data.frame")
  expect_equal(ncol(dat), 14)
  expect_named(dat, c("GID_0", "NAME_0", "GID_1", "NAME_1", "VARNAME_1", "NL_NAME_1", "TYPE_1",
                         "ENGTYPE_1", "CC_1", "HASC_1", "group", "long", "lat", "order"))

  dat_head <- structure(list(GID_0 = c("AUS", "AUS", "AUS", "AUS", "AUS", "AUS"),
                             NAME_0 = c("Australia", "Australia", "Australia", "Australia", "Australia", "Australia"),
                             GID_1 = c("AUS.1_1", "AUS.1_1", "AUS.1_1", "AUS.1_1", "AUS.1_1", "AUS.1_1"),
                             NAME_1 = c("Ashmore and Cartier Islands", "Ashmore and Cartier Islands", "Ashmore and Cartier Islands",
                                        "Ashmore and Cartier Islands", "Ashmore and Cartier Islands", "Ashmore and Cartier Islands"),
                             VARNAME_1 = c(NA_character_, NA_character_, NA_character_, NA_character_, NA_character_, NA_character_),
                             NL_NAME_1 = c(NA_character_, NA_character_, NA_character_, NA_character_, NA_character_, NA_character_),
                             TYPE_1 = c("Territory", "Territory", "Territory", "Territory", "Territory", "Territory"),
                             ENGTYPE_1 = c("Territory", "Territory", "Territory", "Territory", "Territory", "Territory"),
                             CC_1 = c("12", "12", "12", "12", "12", "12"),
                             HASC_1 = c("AU.AS", "AU.AS", "AU.AS", "AU.AS", "AU.AS", "AU.AS"),
                             group = c(1L, 1L, 1L, 1L, 1L, 2L),
                             long = c(123.55555725, 123.55536652, 123.5524292, 123.55358887, 123.55555725, 123.01777649),
                             lat = c(-12.53056812, -12.53212929, -12.53137302, -12.53038979, -12.53056812, -12.25916862),
                             order = c(1L, 2L, 3L, 4L, 5L, 1L)),
                        row.names = c(NA, -6L), class = c("tbl_df", "tbl", "data.frame"))
  expect_equivalent(head(dat), dat_head)
})
