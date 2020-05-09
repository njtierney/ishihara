#' Is an SF object within or intersecting some other SF object?
#'
#' This is a wrapper around `sf::st_within` that returns a logical vector
#'
#' @param x SF object to compare if X is within it
#' @param y SF object to compare if X is within it
#'
#' @return logical vector
#' @export
#' @rdname sf-helper
is_sf_within <- function(x, y) {
  as.logical(lengths(sf::st_within(x, y)))
}

#' @name sf-helper
#' @export
is_sf_intersects <- function(x, y) {
  as.logical(lengths(sf::st_intersects(x, y)))
}
