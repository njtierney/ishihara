#' Calculate circle height
#'
#' @param x circle created by [create_circle_plate()]
#'
#' @return numeric height of circle
#' @name circle_height
#' @export
circle_height <- function(x){
  UseMethod("circle_height")
}

#' @rdname circle_height
#' @export
circle_height.sf <- function(x){
  range(sf::st_bbox(x)["ymin"],
        sf::st_bbox(x)["ymax"]) %>%
    diff() %>%
    round()
}

#' @rdname circle_height
#' @export
circle_height.data.frame <- function(x){
  range(x$y) %>%
    round() %>%
    diff()
}
