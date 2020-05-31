#' Plot the ishihara plate
#'
#' @param overlayed_circle overlayed circle
#'
#' @export
gg_ishihara <- function(overlayed_circle){
  ggplot2::ggplot(overlayed_circle) +
    ggplot2::geom_sf(ggplot2::aes(fill = in_text),
          colour = "white") +
    ggplot2::theme_void() +
    ggplot2::theme(legend.position = "none")
}
