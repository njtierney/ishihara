#' Font increase
#'
#' @param font_df font created by [glyph()]
#' @param increase how much to multiply font size by
#'
#' @return data.frame increased by a given increase size
#' @export
#'
#' @examples
#' glyph("s") %>% font_increase(10)
font_increase <- function(font_df, increase){
  font_df %>%
    dplyr::mutate(x = x * increase,
                  y = y * increase)
}

#' Font Center
#'
#' Centers a font around 0
#'
#' @param font_df font created by [glyph()]
#'
#' @return `font_df` but the x and y values are scaled on 0
#' @export
#'
#' @examples
#' glyph("s") %>% font_increase(10) %>% font_center()
font_center <- function(font_df){
  font_df %>%
    dplyr::mutate_at(dplyr::vars(x, y), scale, scale = FALSE)
}

#' Proportion of the height of packed circles
#'
#' @param prop numeric
#' @param circle circle packing data frame with [create_circle_plate()]
#'
#' @return numeric of the size of the font increase
#'
#' @export
#' @examples
#' circle_plate <- create_circle_plate()
#' prop_circle_height(0.8, circle_plate)
prop_circle_height <- function(prop, circle){
  prop * circle_height(circle) * 2
}

#' Rescale the font to fit inside the circle packings
#'
#' @param font_df font created by [glyph()]
#' @param circle_df circle packing data frame with [create_circle_plate()]
#' @param prop proportion of the circle size to cover. Default is 0.8
#'
#' @return rescaled font to cover the proportion of the height of the circle
#' @examples
#' letter_s <- glyph("s")
#' circle_plate <- create_circle_plate()
#' letter_s_bigger <- font_rescale(letter_s, circle_plate)
#' @export
font_rescale <- function(font_df,
                         circle_df,
                         prop = 0.8){
  new_font_size <- prop_circle_height(prop, circle_df)

  font_df %>%
    font_increase(new_font_size) %>%
    font_center()
}
