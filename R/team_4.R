#' Generating dataframes from shapefiles for smooth maps
#' @param file A path to a shape file
#' @param tolerance A numeric value specifying the default value at which to thin the polygon. Generally less than 0.1
#' @return A dataframe with lat and long coordinates to plot a map
#'
#' @importFrom methods as
#' @export
#' @examples
#' filename <- system.file("extdata", "gadm36_PAN_1.shp", package = "smoothMap")
#' dat <- team_4(filename, tolerance = 0.01)
#' if (require(ggplot2))
#'   ggplot(dat, aes(x = long, y = lat, group = group)) +
#'     geom_polygon(color = "black", fill = "white", size = 0.2) +
#'     labs(x = "Longitude", y = "Latitude", title = "Panama") +
#'     coord_fixed()
team_4 <- function(file, tolerance){
    # initial checks
    checkmate::assertNumber(tolerance)
    if(tolerance > 0.5){
      warning("Tolerance above 0.5 may result in map losing features")
    }
    if(tools::file_ext(file) != "shp"){
      stop("File must be shape file (.shp) to proceed")
    }
    # function to unlist geometry tibble within shapefile
    poly2df <- function(feature) {
      feature <- unlist(feature, recursive = FALSE)
      lapply(feature, function(x) {
        dplyr::mutate(
          dplyr::rename_all(data.frame(x), ~ c("long", "lat")), order = dplyr::row_number())
      }) %>% tibble::tibble(polygon = .)
    }
    # Now read in shape file
      ozbig <- sf::read_sf(file)
      oz_st <- maptools::thinnedSpatialPoly(as(ozbig, "Spatial"),
                                            tolerance = tolerance, min = 0.001, topologyPreserve = TRUE)
      oz <- sf::st_as_sf(oz_st)
      tibble::as_tibble(oz) %>% dplyr::mutate(new = purrr::map(geometry, poly2df)) %>% dplyr::select(-geometry) %>%
      tidyr::unnest() %>% dplyr::mutate(group = dplyr::row_number()) %>% tidyr::unnest()
}

