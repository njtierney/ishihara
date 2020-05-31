#' Create a plate of circles on which the ishihara plate will be created
#'
#' @return data.frame of circles
#' @export
#'
#' @examples
#' circle_plate <- create_circle_plate()
create_circle_plate <- function(){

    circle_vec <- sample(x = (c(25, 50, 125)/100),
                         size = 1000,
                         replace = TRUE)

    create_poly_packings(areas = circle_vec,
                         n_points = 50)
}
