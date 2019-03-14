---
title: "STAT585_LAB3"
author: "Team 4"
output:
  html_document:
    keep_md: True
---

## Link
[https://github.com/lydiaPenglish/smoothMap](https://github.com/lydiaPenglish/smoothMap)

## Team Members
- Lydia English
- Yang Qiao
- Xiyuan Sun



## Description
The goal of `smoothMap` is to generate a function to help map files.

## Installation
You can install the released version of Mygit from [Github](https://github.com/lydiaPenglish/smoothMap) with:
``` r
devtools::install_github("lydiaPenglish/smoothMap")
```

## Example
This is a basic example which shows you how to solve a common problem:


```r
library(smoothMap)
filename <- system.file("extdata", "gadm36_AUS_1.shp", package = "smoothMap")

dat <- team_1(filename, tolerance = 0.1)
if (require(ggplot2))
  ggplot(dat, aes(x = long, y = lat, group = group)) +
    geom_polygon(color = "black", fill = "white", size = 0.2) +
    labs(x = "Longitude", y = "Latitude", title = "Australia") +
    coord_fixed() +
    theme_bw() +
    theme(plot.title = element_text(hjust = 0.5))
```

<img src="README_files/figure-html/example-1.png" style="display: block; margin: auto;" />
