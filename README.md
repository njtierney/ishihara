
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ishihara

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of ishihara is to create ishihara plates, which can help assess
colourblindness.

There are a few implementations of this test around the web, but I
haven’t seen one that worked for R, so here is my crack at
implementing it.

## Installation

The development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("njtierney/ishihara")
```

## Proof of Concept

I had an idea on how I could maybe create this kind of figure in R,
using spatial tools. The general process is:

1.  Create a bunch of circles with `packcircles`
2.  Convert that to an SF object
3.  Pull in a vector font from `gridfont`
4.  Convert that font into an SF object
5.  Overlay the two SF objects and see where they intersect
6.  Plot the circles that are intersected by the text
7.  Change the colour palette in ggplot2 to see the impact of
    colourblindness

<!-- end list -->

``` r
library(ishihara)
## basic example code
library(gridfont)
library(sf)
#> Linking to GEOS 3.7.2, GDAL 2.4.2, PROJ 5.2.0
suppressPackageStartupMessages(library(dplyr))
library(ggplot2)
library(details)
```

<details closed>

``` r
cast_font_sf <- function(font_df){
  font_df %>% 
  st_as_sf(coords = c("x", "y")) %>% 
  group_by(char) %>%
  summarise(do_union = FALSE) %>%
  st_cast("LINESTRING") %>% 
  ungroup() 
}

font_increase <- function(font_df, size){
  font_df %>% 
    mutate(x = x * size,
           y = y * size)
}


create_circle_plate <- function(){
circle_vec <- sample(x = ((1:125)/100),
                     size = 1000,
                     replace = TRUE)

create_poly_packings(areas = circle_vec, n_points = 50) %>% 
  cast_packing_poly()
}

text_sf <- function(text){
  create_text_df(text, font='smooth') %>% 
  font_increase(4)  %>% 
  mutate_at(vars(x, y), scale, scale = FALSE) %>% 
  mutate(y = y + 3) %>% 
  cast_font_sf()
}

overlay_text_in_circle <- function(circle_plate, text_sf){
  circle_plate %>% 
    mutate(in_text = is_sf_intersects(circle_plate, text_sf))
}

plot_ishihara <- function(overlayed_text){
  ggplot(overlayed_text) +
  geom_sf(aes(fill = in_text),
          colour = "white") +
  theme_void() +
  theme(legend.position = "none")
}

ishihara_data <- function(text){
  circle_plate <- create_circle_plate()
  overlay_text_in_circle(circle_plate, text_sf(text))
}
```

</details>

I’m still working through the details of the implementation and
usability, but the general idea is to create something like this:

``` r
cb_1 <- ishihara_data("1")

gg_ishihara <- plot_ishihara(cb_1)
gg_ishihara
gg_ishihara + scale_fill_brewer(palette = "Dark2")
gg_ishihara + scale_fill_viridis_d()
gg_ishihara + scale_fill_manual(values = c("black", "grey90"))
gg_ishihara + scale_fill_manual(values = c("red", "green"))
```

<img src="man/figures/README-ishihara-example-1.png" width="20%" /><img src="man/figures/README-ishihara-example-2.png" width="20%" /><img src="man/figures/README-ishihara-example-3.png" width="20%" /><img src="man/figures/README-ishihara-example-4.png" width="20%" /><img src="man/figures/README-ishihara-example-5.png" width="20%" />
