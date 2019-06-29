#' Chicklet (rounded segmented column) charts
#'
#' @section Aesthetics:
#' `geom_chicklet()` understands the following aesthetics:
#' - `x`
#' - `y`
#' - `alpha`
#' - `colour`
#' - `fill`
#' - `group`
#' - `linetype`
#' - `size`
#' @inheritParams ggplot2::layer
#' @inheritParams ggplot2::geom_point
#' @inheritParams ggplot2::geom_col
#' @param radius corner radius (default 6pt)
#' @export
#' @rdname geom_chicklet
geom_chicklet <- function(mapping = NULL, data = NULL, position = "stack",
                          radius = grid::unit(6, "pt"), ..., width = NULL,
                          na.rm = FALSE, show.legend = NA, inherit.aes = TRUE) {
  layer(
    data = data, mapping = mapping, stat = "identity",
    geom = GeomChicklet, position = position, show.legend = show.legend,
    inherit.aes = inherit.aes, params = list(
      width = width, radius = radius, na.rm = na.rm, ...
    )
  )
}

#' ggchicklet-ggplot2-ggproto
#' @format NULL
#' @usage NULL
#' @export
GeomChicklet <- ggproto(
  "GeomChicklet", GeomRrect,
  required_aes = c("x", "y"),

  non_missing_aes = c("xmin", "xmax", "ymin", "ymax"),

  setup_data = function(data, params) {
    data$width <- data$width %||%
      params$width %||% (resolution(data$x, FALSE) * 0.9)
    transform(data,
              ymin = pmin(y, 0), ymax = pmax(y, 0),
              xmin = x - width / 2, xmax = x + width / 2, width = NULL
    )
  },

  draw_panel = function(self, data, panel_params, coord,width = NULL, radius = grid::unit(6, "pt")) {
    ggproto_parent(GeomRrect, self)$draw_panel(data, panel_params, coord, radius = radius)
  }
)
