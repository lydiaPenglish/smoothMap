#' Generating dataframes from shapefiles for smooth maps
#'
#' @param file A path to a shape file
#' @param tolerance A numeric value specifying the default value at which to thin the polygon. Generally less than 0.1
#'
#' @return A dataframe with lat and long coordinates to plot a map
#' @export
#'
#' @examples
#' filename <- system.file("extdata", "gadm36_CUB_1.shp", package = "smoothMap")
#' dat <- team_2(filename, tolerance = 0.01)
#' if (require(ggplot2))
#' ggplot(dat, aes(x = long, y = lat, group = group)) +
#'     geom_polygon(color = "black", fill = "white", size = 0.2) +
#'     labs(x = "Longitude", y = "Latitude", title = "Panama") +
#'     coord_fixed()
team_2 <- function(file,tolerance){

  # initial checks
  checkmate::assertNumber(tolerance, lower = 0)
  if(tolerance > 0.5){
    warning("Tolerance above 0.5 may result in map losing features")
  }
  if(tools::file_ext(file) != "shp"){
    stop("File must be shape file (.shp) to proceed")
  }
  ## Help calculate the group.
  ## Input: oz$geometry
  helper.group <- function(geo){

    geo %>% purrr::flatten() %>%
      purrr::flatten()-> dd

    countgrouprep <- purrr::flatten_int(purrr::map(dd, nrow))
    num_group <- length(countgrouprep)
    rep(1:num_group, time = countgrouprep)
  }

  ## Help calculate the order.
  ## Input: oz$geometry[[i]]
  helper.order <- function(geol){
    geol %>% purrr::flatten() -> d
    longlat <- do.call(rbind, d)
    order_num <- sum(purrr::flatten_int(purrr::map(d, nrow)))
    order <- seq(1:order_num)
    cbind(longlat, order)
  }

  ## Converts shapefile to lat-long file
  ## Input: oz$geometry
  sh2lat <- function(geofile){
    res <- purrr::map(geofile, .f=helper.order)
    ress <- do.call(rbind, res)
    group <- helper.group(geofile)
    ress <- cbind(ress, group)
    colnames(ress) <- c("long", "lat", "order", "group")
    ress <- as.data.frame(ress)
  }

  ozbig <- sf::read_sf(file)
  oz_st <- maptools::thinnedSpatialPoly(as(ozbig, "Spatial"),
                                        tolerance = tolerance,
                                        minarea = 0.001,
                                        topologyPreserve = TRUE)
  oz <- sf::st_as_sf(oz_st)
  result <- sh2lat(oz$geometry)

  return(result)




}
