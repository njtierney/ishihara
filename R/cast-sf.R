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
  sf::st_as_sf(poly_packing,
               coords = c("x", "y")) %>%
    dplyr::group_by(id) %>%
    dplyr::summarise(do_union = FALSE) %>%
    sf::st_cast("POLYGON") %>%
    dplyr::ungroup()
}
