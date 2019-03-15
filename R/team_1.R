if(getRversion() >= "2.15.1")  utils::globalVariables(c(".", "geometry"))


#' Create a geometry data frame.
#' @description Read a shape file and create a data frame by reforming geometry column to longitude, latitude, order, group.
#'
#' See \href{https://github.com/lydiaPenglish/smoothMap}{smoothMap}.
#'
#' @param file The name of the shape (.shp) file which the data are to be read from.
#' @param tolerance The tolerance value in the metric of the input object.
#' @return A data frame.
#'
#' @importFrom methods as
#' @export
#' @author Yang Qiao
#'
#' @examples
#' filename <- system.file("extdata", "gadm36_MEX_1.shp", package = "smoothMap")
#' dat <- team_1(filename, tolerance = 0.1)
#' if (require(ggplot2))
#'   ggplot(dat, aes(x = long, y = lat, group = group)) +
#'     geom_polygon(color = "black", fill = "white", size = 0.2) +
#'     labs(x = "Longitude", y = "Latitude", title = "Mexico") +
#'     coord_fixed()
team_1 <- function(file, tolerance = 0.1) {
  poly2df <- function(feature) {
    feature %>%
      purrr::map_depth(2, function(y) dplyr::mutate(dplyr::rename_all(data.frame(y), ~ c("long", "lat")),
                                                    order = dplyr::row_number())) %>%
      purrr::flatten() %>%
      dplyr::tibble(poly = .)
  }

  checkmate::assert_file_exists(file, extension = "shp")
  checkmate::assert_number(tolerance, lower = 0, finite = T)

  data <- sf::read_sf(file)
  oz <- maptools::thinnedSpatialPoly(as(data, "Spatial"),
                                     tol = tolerance, min = 0.001, topologyPreserve = T) %>%
    sf::st_as_sf()

  dplyr::as_tibble(oz) %>%
    dplyr::mutate(new = purrr::map(geometry, poly2df)) %>%
    dplyr::select(-geometry) %>%
    tidyr::unnest() %>%
    dplyr::mutate(group = dplyr::row_number()) %>%
    tidyr::unnest()
}
