#' Chicklet (rounded segmented column) charts
#'
#' This geom behaves much like [ggplot2::geom_col()] but provides the option to
#' set a corner radius to turn sharp-edged bars into rounded rectangles; it also
#' sets some sane defaults for making chicklet charts.
#'
#' \if{html}{
#' A sample of the output from \code{geom_chicklet()}:
#'
#' \figure{chickletex.png}{options: width="100\%" alt="Figure: chickletex.png"}
#' }
#'
#' \if{latex}{
#' A sample of the output from \code{geom_chicklet()}:
#'
#' \figure{chickletex.png}{options: width=10cm}
#' }
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
#'
#' @inheritParams ggplot2::layer
#' @inheritParams ggplot2::geom_point
#' @inheritParams ggplot2::geom_col
#' @param radius corner radius (default 3px)
#' @note the chicklet/segment stack positions are default set to be reversed (i.e.
#'       left-to-right/bottom-to-top == earliest to latest order).
#' @export
#' @rdname geom_chicklet
#' @examples
#' library(ggplot2)
#'
#' data("debates2019")
#'
#' # set the speaker order
#' spkr_ordr <- aggregate(elapsed ~ speaker, data = debates2019, sum)
#' spkr_ordr <- spkr_ordr[order(spkr_ordr[["elapsed"]]),]
#'
#' debates2019$speaker <- factor(debates2019$speaker, spkr_ordr$speaker)
#'
#' ggplot(debates2019) +
#'   # use 'group' to control left-to-right order
#'   geom_chicklet(aes(speaker, elapsed, group = timestamp, fill = topic)) +
#'   scale_y_continuous(expand = c(0, 0.01), position = "right") +
#'   coord_flip() +
#'   labs(x = NULL, y = "Minutes Spoken", fill = NULL) +
#'   theme_minimal() +
#'   theme(panel.grid.major.y = element_blank()) +
#'   theme(legend.position = "bottom")
geom_chicklet <- function(mapping = NULL, data = NULL,
                          position = ggplot2::position_stack(reverse = TRUE),
                          radius = grid::unit(3, "pt"), ..., width = NULL,
                          na.rm = FALSE, show.legend = NA, inherit.aes = TRUE) {
  layer(
    data = data, mapping = mapping, stat = "identity",
    geom = GeomChicklet, position = position, show.legend = show.legend,
    inherit.aes = inherit.aes, params = list(
      width = width, radius = radius, na.rm = na.rm, ...
    )
  )
}

draw_key_rrect <- function(data, params, size) { # nocov start
  grid::roundrectGrob(
    r = params$radius,
    default.units = "native",
    width = 1, height = 0.6,
    name = "lkey",
    gp = grid::gpar(
      col = params$color %l0% "white",
      fill = alpha(data$fill %||% data$colour %||% "grey20", data$alpha),
      lty = data$linetype %||% 1
    )
  )
} # nocov end

#' ggchicklet-ggplot2-ggproto
#' @format NULL
#' @usage NULL
#' @export
GeomChicklet <- ggproto( # nocov start
  "GeomChicklet", GeomRrect,

  required_aes = c("x", "y"),

  default_aes = ggplot2::aes(
    colour = "white", fill = "grey35", size = 0.5, linetype = 1, alpha = NA
  ),

  non_missing_aes = c("xmin", "xmax", "ymin", "ymax"),

  setup_data = function(data, params) {
    data$width <- data$width %||%
      params$width %||% (resolution(data$x, FALSE) * 0.9)
    transform(data,
              ymin = pmin(y, 0), ymax = pmax(y, 0),
              xmin = x - width / 2, xmax = x + width / 2, width = NULL
    )
  },

  draw_panel = function(self, data, panel_params, coord,width = NULL, radius = grid::unit(3, "pt")) {
    ggproto_parent(GeomRrect, self)$draw_panel(data, panel_params, coord, radius = radius)
  },

  draw_key = draw_key_rrect

) # nocov end
