
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Signed
by](https://img.shields.io/badge/Keybase-Verified-brightgreen.svg)](https://keybase.io/hrbrmstr)
![Signed commit
%](https://img.shields.io/badge/Signed_Commits-100%25-lightgrey.svg)
[![Linux build
Status](https://travis-ci.org/hrbrmstr/ggchicklet.svg?branch=master)](https://travis-ci.org/hrbrmstr/ggchicklet)
[![Coverage
Status](https://codecov.io/gh/hrbrmstr/ggchicklet/branch/master/graph/badge.svg)](https://codecov.io/gh/hrbrmstr/ggchicklet)
![Minimal R
Version](https://img.shields.io/badge/R%3E%3D-3.2.0-blue.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

# ggchicklet

Create Chicklet (Rounded Segmented Column) Charts

## Description

Sometimes it is useful to stylize column charts a bit more than just
bland rectangles. Methods are provided to create rounded rectangle
segmented column charts (i.e. “chicklets”).

## What’s Inside The Tin

  - `debates2019`: 2019-2020 U.S. Democratic Debate Candidate/Topic
    Times
  - `geom_chicklet`: Chicklet (rounded segmented column) charts

The following functions are implemented:

## Installation

``` r
install.packages("ggchicklet", repos = "https://cinc.rud.is")
# or
remotes::install_git("https://git.rud.is/hrbrmstr/ggchicklet.git")
# or
remotes::install_git("https://git.sr.ht/~hrbrmstr/ggchicklet")
# or
remotes::install_gitlab("hrbrmstr/ggchicklet")
# or
remotes::install_bitbucket("hrbrmstr/ggchicklet")
# or
remotes::install_github("hrbrmstr/ggchicklet")
```

NOTE: To use the ‘remotes’ install options you will need to have the
[{remotes} package](https://github.com/r-lib/remotes) installed.

## Usage

``` r
library(ggchicklet)

# current version
packageVersion("ggchicklet")
## [1] '0.2.0'
```

### From the NYTimes

``` r
library(hrbrthemes)
library(tidyverse)

data("debates2019")

debates2019 %>%
  filter(debate_group == 1) %>% 
  mutate(speaker = fct_reorder(speaker, elapsed, sum, .desc=FALSE)) %>%
  mutate(topic = fct_other(
    topic,
    c("Immigration", "Economy", "Climate Change", "Gun Control", "Healthcare", "Foreign Policy"))
  ) %>%
  ggplot(aes(speaker, elapsed, group = timestamp, fill = topic)) +
  geom_chicklet(width = 0.75) +
  scale_y_continuous(
    expand = c(0, 0.0625),
    position = "right",
    breaks = seq(0, 14, 2),
    labels = c(0, sprintf("%d min.", seq(2, 14, 2)))
  ) +
  scale_fill_manual(
    name = NULL,
    values = c(
      "Immigration" = "#ae4544",
      "Economy" = "#d8cb98",
      "Climate Change" = "#a4ad6f",
      "Gun Control" = "#cc7c3a",
      "Healthcare" = "#436f82",
      "Foreign Policy" = "#7c5981",
      "Other" = "#cccccc"
    ),
    breaks = setdiff(unique(debates2019$topic), "Other")
  ) +
  guides(
    fill = guide_legend(nrow = 1)
  ) +
  coord_flip() +
  labs(
    x = NULL, y = NULL, fill = NULL,
    title = "How Long Each Candidate Spoke",
    subtitle = "Nights 1 & 2 of the June 2019 Democratic Debates",
    caption = "Each bar segment represents the length of a candidate’s response to a question.\n\nOriginals <https://www.nytimes.com/interactive/2019/admin/100000006581096.embedded.html?>\n<https://www.nytimes.com/interactive/2019/admin/100000006584572.embedded.html?>\nby @nytimes Weiyi Cai, Jason Kao, Jasmine C. Lee, Alicia Parlapiano and Jugal K. Patel\n\n#rstats reproduction by @hrbrmstr"
  ) +
  theme_ipsum_rc(grid="X") +
  theme(axis.text.x = element_text(color = "gray60", size = 10)) +
  theme(legend.position = "top")
```

<img src="man/figures/README-nyt-1.png" width="100%" />

## ggchicklet Metrics

| Lang | \# Files |  (%) |  LoC |  (%) | Blank lines |  (%) | \# Lines |  (%) |
| :--- | -------: | ---: | ---: | ---: | ----------: | ---: | -------: | ---: |
| HTML |        5 | 0.33 | 7860 | 0.94 |        1858 | 0.96 |      239 | 0.54 |
| R    |        8 | 0.53 |  350 | 0.04 |          34 | 0.02 |      121 | 0.27 |
| Rmd  |        2 | 0.13 |  117 | 0.01 |          45 | 0.02 |       85 | 0.19 |

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
