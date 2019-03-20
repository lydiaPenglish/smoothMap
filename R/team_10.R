#' Generating dataframes from shapefiles for smooth maps
#'
#' @param file A path to a shape file
#' @param tolerance A numeric value specifying the default value at which to thin the polygon. Generally less than 0.1
#'
#' @return A dataframe with lat and long coordinates to plot a map
#' @importFrom method as
#' @export
#' @author Xiyuan Sun
#'
#' @examples
#' filename <- system.file("extdata", "gadm36_CUB_1.shp", package = "smoothMap")
#' dat <- team_10(filename, tolerance = 0.01)
#' if (require(ggplot2))
#'   ggplot(dat, aes(x = long, y = lat, group = group)) +
#'     geom_polygon(color = "black", fill = "white", size = 0.2) +
#'     labs(x = "Longitude", y = "Latitude", title = "Panama") +
#'     coord_fixed()
#'
#'
team_10 <- function(file, tolerance){
  # initial checks
  checkmate::assert_file_exists(file, extension = "shp")
  checkmate::assertNumber(tolerance, lower = 0)
  if(tolerance > 0.5){
    warning("Tolerance above 0.5 may result in map losing features")
  }
  if(tools::file_ext(file) != "shp"){
    stop("File must be shape file (.shp) to proceed")
  }
  # Now read in shape file
  shpbig <- sf::read_sf(file)
  shp_st <- maptools::thinnedSpatialPoly(
    as(shpbig, "Spatial"), tolerance = tolerance,
    minarea = 0.001, topologyPreserve = TRUE)

  shp <- sf::st_as_sf(shp_st)

  shpSmall <- shp %>%
    dplyr::select(NAME_1, geometry) %>%
    dplyr::group_by() %>%
    dplyr::mutate(coord = geometry %>%
                    purrr::map(.f = function(m) purrr::flatten(.x=m)),
                  region = dplyr::row_number())%>% tidyr::unnest

  sf::st_geometry(shpSmall) <- NULL

  shpSmall <- shpSmall %>%
    dplyr::mutate(coord = coord %>%
                    purrr::map(.f = function(m) tibble::as_tibble(m)),group = dplyr::row_number()) %>%
    tidyr::unnest %>%
    stats::setNames(c("name", "region","group", "long", "lat"))

  return(shpSmall)

}




