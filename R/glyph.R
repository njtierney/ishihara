#' Create a text polygon
#'
#' @param glyph text input - use only one character
#' @param family font family - see [sysfonts::font_families()]
#' @param face Font face, possible values are "regular", "bold", "italic" and
#'   "bolditalic".
#' @param nseg The number of line segments to approximate a piece of curve in
#'   the outline. The larger nseg is, the smoother text outlines would be.
#'   Usually a value between 5~20 would be enough.
#' @return tibble with columns `x`, `y`, and `glyph`
#' @export
#'
#' @examples
#' glyph("s")
glyph <- function(glyph,
                  family = "serif",
                  face = "regular",
                  nseg = 10) {

  if (nchar(glyph) > 1){
    stop("'glyph' only takes one character, input '",
         glyph,
         "' is more than one character")
  }

  fontr::glyph_polygon(ch = glyph,
                       family = family,
                       face = face,
                       nseg = nseg) %>%
    dplyr::mutate(glyph = glyph) %>%
    tibble::as_tibble()
}
