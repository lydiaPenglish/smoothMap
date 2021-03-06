% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/team_4.R
\name{team_4}
\alias{team_4}
\title{Generating dataframes from shapefiles for smooth maps}
\usage{
team_4(file, tolerance)
}
\arguments{
\item{file}{A path to a shape file}

\item{tolerance}{A numeric value specifying the default value at which to thin the polygon. Generally less than 0.1}
}
\value{
A dataframe with lat and long coordinates to plot a map
}
\description{
Generating dataframes from shapefiles for smooth maps
}
\examples{
filename <- system.file("extdata", "gadm36_PAN_1.shp", package = "smoothMap")
dat <- team_4(filename, tolerance = 0.01)
if (require(ggplot2))
  ggplot(dat, aes(x = long, y = lat, group = group)) +
    geom_polygon(color = "black", fill = "white", size = 0.2) +
    labs(x = "Longitude", y = "Latitude", title = "Panama") +
    coord_fixed()
}
