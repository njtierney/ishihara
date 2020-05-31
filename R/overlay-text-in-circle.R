#' Overlay text over circle packings and identify intersections
#'
#' @param circle_sf SF object of circle packings
#' @param glyph_sf SF object of text
#'
#' @return `circle_df` with extra column, `in_text` that identified whether
#'   `glyph_sf` is on a circle in `circle_df`.
#' @export
#'
#' @examples
#' circle_sf <- create_circle_plate() %>% cast_packing_poly()
#' glyph_sf <- glyph("s") %>% cast_font_sf()
overlay_text_in_circle <- function(circle_sf, glyph_sf){
  # perhaps rename, "find_intersects(x, y)"
  circle_sf %>%
    dplyr::mutate(in_text = is_sf_intersects(circle_sf, glyph_sf))
}
