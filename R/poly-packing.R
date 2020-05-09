#' Create polygons of a given area that do not overlap
#'
#' @param areas numeric vector of areas
#' @param n_points number of points to create the polygon. Three = triangle,
#'   and about 50 or more gives a convincing circle.
#'
#' @return tibble of x, y coords of the points, and id, identifying each polygon
#'
#' @export
#' @examples
#' # create a bunch of triangles that do not overlap
#' create_poly_packings(areas = c(1:2), n_points = 3)
create_poly_packings <- function(areas,
                                 n_points){

  n_circles <- length(areas)

  areas %>%
    sample(n_circles) %>%
    packcircles::circleProgressiveLayout() %>%
    packcircles::circleLayoutVertices(npoints = n_points) %>%
    tibble::as_tibble()

}
