#' Cast a polygon created with `create_poly_packings` as an SF object
#'
#' @param poly_packing polygon created with `create_poly_packings` as an SF object
#'
#' @return SF object
#' @export
#'
#' @examples
#' packed_poly <- create_poly_packings(areas = c(1:2), n_points = 3)
#' cast_packing_poly(packed_poly)
cast_packing_poly <- function(poly_packing){
  # perhaps rename "cast_circle_sf"
  sf::st_as_sf(poly_packing,
               coords = c("x", "y")) %>%
    dplyr::group_by(id) %>%
    dplyr::summarise(do_union = FALSE) %>%
    sf::st_cast("POLYGON") %>%
    dplyr::ungroup()
}

#' Convert font into Spatial SF object
#'
#' @param font_df font created by [glyph()]
#'
#' @return font polygon as an SF object
#' @export
#'
#' @examples
#' letter_s <- glyph("s")
#' letter_s_sf <- cast_font_sf(letter_s)
cast_font_sf <- function(font_df){
  # perhaps rename cast_glyph_sf
  font_df %>%
    sf::st_as_sf(coords = c("x", "y")) %>%
    dplyr::group_by(glyph) %>%
    dplyr::summarise(do_union = FALSE) %>%
    sf::st_cast("POLYGON") %>%
    dplyr::ungroup()
}
