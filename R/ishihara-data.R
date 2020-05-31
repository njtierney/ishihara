#' Create Ishihara data
#'
#' @param text character vector, only one character
#'
#' @return ishihara plate with packed circles that are marked
#'   with whether the text overlays on the circles
#' @export
#'
#' @examples
#' ishihara_data("s")
ishihara_data <- function(text){

  circle_plate <- create_circle_plate()
  # Convert circles to an `sf` spatial object.
  circle_plate_sf <- cast_packing_poly(circle_plate)
  # Pull in a vector font (and resize the font)
  letter <- glyph(text) %>% font_rescale(circle_plate)
  # Convert that font into an SF object
  letter_sf <- cast_font_sf(letter)
  # Overlay the two SF objects and see where they intersect
  overlayed_circle <- overlay_text_in_circle(circle_plate_sf, letter_sf)

  return(overlayed_circle)
}
