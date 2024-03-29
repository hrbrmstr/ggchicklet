% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom-chicklet.R
\docType{data}
\name{geom_chicklet}
\alias{geom_chicklet}
\alias{GeomChicklet}
\title{Chicklet (rounded segmented column) charts}
\format{
An object of class \code{GeomChicklet} (inherits from \code{GeomRrect}, \code{Geom}, \code{ggproto}, \code{gg}) of length 7.
}
\usage{
geom_chicklet(
  mapping = NULL,
  data = NULL,
  position = ggplot2::position_stack(reverse = TRUE),
  radius = grid::unit(3, "pt"),
  ...,
  width = NULL,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
)

GeomChicklet
}
\arguments{
\item{mapping}{Set of aesthetic mappings created by \code{\link[ggplot2:aes]{aes()}} or
\code{\link[ggplot2:aes_]{aes_()}}. If specified and \code{inherit.aes = TRUE} (the
default), it is combined with the default mapping at the top level of the
plot. You must supply \code{mapping} if there is no plot mapping.}

\item{data}{The data to be displayed in this layer. There are three
options:

If \code{NULL}, the default, the data is inherited from the plot
data as specified in the call to \code{\link[ggplot2:ggplot]{ggplot()}}.

A \code{data.frame}, or other object, will override the plot
data. All objects will be fortified to produce a data frame. See
\code{\link[ggplot2:fortify]{fortify()}} for which variables will be created.

A \code{function} will be called with a single argument,
the plot data. The return value must be a \code{data.frame}, and
will be used as the layer data. A \code{function} can be created
from a \code{formula} (e.g. \code{~ head(.x, 10)}).}

\item{position}{Position adjustment, either as a string, or the result of
a call to a position adjustment function.}

\item{radius}{corner radius (default 3pt)}

\item{...}{Other arguments passed on to \code{\link[ggplot2:layer]{layer()}}. These are
often aesthetics, used to set an aesthetic to a fixed value, like
\code{colour = "red"} or \code{size = 3}. They may also be parameters
to the paired geom/stat.}

\item{width}{Bar width. By default, set to 90\% of the resolution of the data.}

\item{na.rm}{If \code{FALSE}, the default, missing values are removed with
a warning. If \code{TRUE}, missing values are silently removed.}

\item{show.legend}{logical. Should this layer be included in the legends?
\code{NA}, the default, includes if any aesthetics are mapped.
\code{FALSE} never includes, and \code{TRUE} always includes.
It can also be a named logical vector to finely select the aesthetics to
display.}

\item{inherit.aes}{If \code{FALSE}, overrides the default aesthetics,
rather than combining with them. This is most useful for helper functions
that define both data and aesthetics and shouldn't inherit behaviour from
the default plot specification, e.g. \code{\link[ggplot2:borders]{borders()}}.}
}
\description{
This geom behaves much like \code{\link[ggplot2:geom_bar]{ggplot2::geom_col()}} but provides the option to
set a corner radius to turn sharp-edged bars into rounded rectangles; it also
sets some sane defaults for making chicklet charts.
}
\details{
\if{html}{
A sample of the output from \code{geom_chicklet()}:

\figure{README-nyt-1.png}{options: width="100\%" alt="Figure: README-nyt-1.png"}
}

\if{latex}{
A sample of the output from \code{geom_chicklet()}:

\figure{README-nyt-1.png}{options: width=10cm}
}
}
\note{
the chicklet/segment stack positions are default set to be reversed (i.e.
left-to-right/bottom-to-top == earliest to latest order).
}
\section{Aesthetics}{

\code{geom_chicklet()} understands the following aesthetics:
\itemize{
\item \code{x}
\item \code{y}
\item \code{alpha}
\item \code{colour}
\item \code{fill}
\item \code{group}
\item \code{linetype}
\item \code{size}
}

Use both \code{fill} and \code{group} when you want a fill colour per-segment but
want to order the segments by another column (as in the Examples).
}

\examples{
library(ggplot2)

data("debates2019")

# set the speaker order
spkr_ordr <- aggregate(elapsed ~ speaker, data = debates2019, sum)
spkr_ordr <- spkr_ordr[order(spkr_ordr[["elapsed"]]),]

debates2019$speaker <- factor(debates2019$speaker, spkr_ordr$speaker)

ggplot(debates2019) +
  # use 'group' to control left-to-right order
  geom_chicklet(aes(speaker, elapsed, group = timestamp, fill = topic)) +
  scale_y_continuous(expand = c(0, 0.01), position = "right") +
  coord_flip() +
  labs(x = NULL, y = "Minutes Spoken", fill = NULL) +
  theme_minimal() +
  theme(panel.grid.major.y = element_blank()) +
  theme(legend.position = "bottom")
}
\keyword{datasets}
