
[![Travis-CI Build
Status](https://travis-ci.org/hrbrmstr/ggchicklet.svg?branch=master)](https://travis-ci.org/hrbrmstr/ggchicklet)
[![Coverage
Status](https://codecov.io/gh/hrbrmstr/ggchicklet/branch/master/graph/badge.svg)](https://codecov.io/gh/hrbrmstr/ggchicklet)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/ggchicklet)](https://cran.r-project.org/package=ggchicklet)

# ggchicklet

Create Chicklet (Rounded Segmented Column) Charts

## Description

Sometimes it is useful to stylize column charts a bit more than just
bland rectangles. Methods are provided to create rounded rectangle
segmented column charts (i.e. “chicklets”).

## What’s Inside The Tin

The following functions are implemented:

## Installation

``` r
devtools::install_git("https://sr.ht.com/~hrbrmstr/ggchicklet.git")
# or
devtools::install_git("https://gitlab.com/hrbrmstr/ggchicklet.git")
# or (if you must)
devtools::install_github("hrbrmstr/ggchicklet")
```

## Usage

``` r
library(ggchicklet)

# current version
packageVersion("ggchicklet")
## [1] '0.1.0'
```

### From the NYTimes

``` r
library(stringi)
library(hrbrthemes)
library(tidyverse)

read.csv(text='"elapsed","timestamp","speaker","topic"
1.0985,"9:02:59 PM","sanders","statement"
0.222333333333333,"9:04:15 PM","sanders","healthcare"
1.07933333333333,"9:05:01 PM","biden","economy"
0.975,"9:06:27 PM","harris","economy"
1.04566666666667,"9:07:53 PM","hickenlooper","other"
0.716,"9:09:05 PM","sanders","trump"
0.7325,"9:09:55 PM","gillibrand","statement"
1.2625,"9:10:52 PM","bennet","healthcare"
0.218166666666667,"9:12:16 PM","gillibrand","healthcare"
1.028,"9:12:48 PM","buttigieg","education"
0.377666666666667,"9:13:49 PM","swalwell","education"
1.0795,"9:14:31 PM","yang","economy"
0.3025,"9:15:50 PM","yang","economy"
1.071,"9:16:25 PM","swalwell","education"
1.06066666666667,"9:17:34 PM","biden","education"
0.0478333333333333,"9:18:42 PM","buttigieg","other"
0.0686666666666667,"9:18:45 PM","sanders","other"
0.0685,"9:18:49 PM","gillibrand","other"
0.332666666666667,"9:18:53 PM","sanders","statement"
0.0976666666666667,"9:19:13 PM","swalwell","other"
0.934333333333333,"9:19:31 PM","harris","economy"
1.149,"9:21:00 PM","gillibrand","healthcare"
1.18566666666667,"9:22:13 PM","buttigieg","healthcare"
1.1795,"9:23:32 PM","biden","healthcare"
1.13083333333333,"9:25:03 PM","sanders","healthcare"
0.441,"9:26:19 PM","sanders","healthcare"
1.2195,"9:27:03 PM","williamson","healthcare"
1.399,"9:28:24 PM","bennet","healthcare"
0.4205,"9:29:53 PM","sanders","healthcare"
0.897666666666667,"9:30:18 PM","harris","healthcare"
0.241,"9:31:20 PM","swalwell","healthcare"
1.22466666666667,"9:32:02 PM","buttigieg","immigration"
1.20316666666667,"9:33:35 PM","biden","healthcare"
1.63116666666667,"9:37:39 PM","harris","immigration"
1.09783333333333,"9:39:49 PM","hickenlooper","immigration"
1.19866666666667,"9:40:55 PM","williamson","immigration"
1.1075,"9:42:13 PM","gillibrand","immigration"
0.784166666666667,"9:43:42 PM","buttigieg","immigration"
0.854166666666667,"9:43:52 PM","buttigieg","other"
1.16416666666667,"9:44:43 PM","biden","immigration"
0.562,"9:46:13 PM","biden","immigration"
0.107666666666667,"9:46:57 PM","biden","immigration"
0.6645,"9:47:06 PM","sanders","immigration"
0.640166666666667,"9:48:01 PM","swalwell","immigration"
1.64033333333333,"9:48:39 PM","harris","immigration"
1.4755,"9:50:44 PM","bennet","foreign policy"
1.104,"9:51:16 PM","bennet","immigration"
0.739833333333333,"9:52:22 PM","yang","foreign policy"
1.30483333333333,"9:53:11 PM","buttigieg","foreign policy"
1.36083333333333,"10:00:20 PM","buttigieg","civil rights"
0.519,"10:01:48 PM","hickenlooper","civil rights"
0.183166666666667,"10:02:22 PM","buttigieg","civil rights"
0.0588333333333333,"10:02:33 PM","swalwell","civil rights"
0.167166666666667,"10:02:36 PM","buttigieg","civil rights"
0.414666666666667,"10:02:46 PM","williamson","civil rights"
0.144166666666667,"10:03:18 PM","harris","civil rights"
1.765,"10:03:30 PM","harris","civil rights"
1.20683333333333,"10:05:32 PM","biden","civil rights"
0.156166666666667,"10:06:44 PM","harris","civil rights"
0.141833333333333,"10:06:54 PM","biden","civil rights"
0.200166666666667,"10:07:02 PM","harris","civil rights"
0.0563333333333333,"10:07:14 PM","biden","civil rights"
0.276666666666667,"10:07:18 PM","harris","civil rights"
0.461,"10:07:34 PM","biden","civil rights"
0.946666666666667,"10:08:32 PM","sanders","economy"
0.6795,"10:09:31 PM","gillibrand","politics"
0.0683333333333333,"10:10:12 PM","biden","politics"
1.188,"10:10:45 PM","bennet","politics"
0.720333333333333,"10:12:08 PM","biden","politics"
0.662,"10:12:51 PM","bennet","politics"
0.914,"10:13:31 PM","gillibrand","politics"
1.11783333333333,"10:14:51 PM","sanders","abortion"
0.248666666666667,"10:16:12 PM","sanders","abortion"
1.46433333333333,"10:16:27 PM","gillibrand","abortion"
1.47366666666667,"10:18:16 PM","harris","climate change"
1.239,"10:19:59 PM","buttigieg","climate change"
1.21166666666667,"10:21:31 PM","hickenlooper","climate change"
1.06166666666667,"10:23:07 PM","biden","climate change"
0.588166666666667,"10:24:14 PM","sanders","climate change"
0.116666666666667,"10:24:56 PM","swalwell","other"
0.935333333333333,"10:25:11 PM","williamson","statement"
0.0903333333333333,"10:26:46 PM","swalwell","gun control"
0.142166666666667,"10:26:56 PM","bennet","statement"
0.132,"10:27:04 PM","gillibrand","statement"
0.236666666666667,"10:27:12 PM","harris","statement"
0.2575,"10:27:26 PM","sanders","statement"
0.444166666666667,"10:27:42 PM","biden","statement"
0.112666666666667,"10:28:14 PM","buttigieg","statement"
0.161,"10:28:23 PM","yang","statement"
0.176166666666667,"10:28:33 PM","hickenlooper","climate change"
0.3165,"10:28:43 PM","williamson","statement"
1.0975,"10:34:06 PM","swalwell","gun control"
0.910333333333333,"10:35:32 PM","sanders","gun control"
0.0488333333333333,"10:36:27 PM","swalwell","gun control"
0.0845,"10:36:30 PM","sanders","gun control"
0.1045,"10:36:35 PM","sanders","gun control"
0.932333333333333,"10:36:43 PM","harris","gun control"
0.8365,"10:38:10 PM","buttigieg","gun control"
0.8175,"10:39:04 PM","biden","gun control"
1.06716666666667,"10:40:23 PM","bennet","statement"
0.182833333333333,"10:41:53 PM","williamson","foreign policy"
0.2585,"10:42:07 PM","hickenlooper","foreign policy"
0.0645,"10:42:25 PM","yang","foreign policy"
0.1835,"10:42:32 PM","buttigieg","foreign policy"
0.104833333333333,"10:42:45 PM","biden","foreign policy"
0.15,"10:42:54 PM","sanders","foreign policy"
0.034,"10:43:05 PM","harris","foreign policy"
0.166166666666667,"10:43:09 PM","gillibrand","foreign policy"
0.162166666666667,"10:43:19 PM","bennet","foreign policy"
0.110666666666667,"10:43:28 PM","swalwell","foreign policy"
1.034,"10:44:04 PM","biden","foreign policy"
0.580833333333333,"10:45:09 PM","sanders","foreign policy"
0.772666666666667,"10:48:54 PM","swalwell","closing"
0.694166666666667,"10:49:44 PM","williamson","closing"
0.902833333333333,"10:50:32 PM","bennet","closing"
0.817166666666667,"10:51:30 PM","hickenlooper","closing"
0.934666666666667,"10:52:24 PM","gillibrand","closing"
0.616166666666667,"10:53:24 PM","yang","closing"
0.967333333333333,"10:54:08 PM","harris","closing"
0.837833333333333,"10:55:11 PM","buttigieg","closing"
0.875,"10:56:08 PM","sanders","closing"
0.8375,"10:57:08 PM","biden","closing"
1.03566666666667,"9:03:05 PM","warren","economy"
1.12783333333333,"9:04:29 PM","klobuchar","economy"
1.133,"9:06:02 PM","orourke","economy"
0.2265,"9:07:20 PM","orourke","economy"
1.0585,"9:07:54 PM","booker","economy"
0.600166666666667,"9:09:08 PM","booker","economy"
0.99,"9:09:50 PM","warren","economy"
0.872,"9:11:03 PM","castro","economy"
1.07,"9:12:00 PM","gabbard","economy"
1.111,"9:13:20 PM","deblasio","economy"
1.13416666666667,"9:14:30 PM","delaney","economy"
1.03016666666667,"9:15:41 PM","inslee","economy"
1.066,"9:16:56 PM","ryan","economy"
1.19566666666667,"9:18:04 PM","warren","economy"
1.07716666666667,"9:19:50 PM","klobuchar","healthcare"
1.10616666666667,"9:21:11 PM","warren","healthcare"
1.16983333333333,"9:22:28 PM","orourke","healthcare"
0.084,"9:23:45 PM","orourke","healthcare"
0.1945,"9:23:50 PM","deblasio","healthcare"
0.0671666666666667,"9:24:01 PM","orourke","healthcare"
0.0583333333333333,"9:24:05 PM","deblasio","healthcare"
0.082,"9:24:09 PM","orourke","healthcare"
1.1265,"9:24:14 PM","delaney","healthcare"
0.907,"9:25:27 PM","gabbard","healthcare"
1.11483333333333,"9:26:26 PM","booker","healthcare"
0.527333333333333,"9:27:37 PM","warren","healthcare"
0.615333333333333,"9:28:09 PM","inslee","healthcare"
0.602,"9:28:51 PM","klobuchar","healthcare"
0.923,"9:29:40 PM","castro","healthcare"
0.680333333333333,"9:30:39 PM","warren","healthcare"
0.663666666666667,"9:31:41 PM","booker","healthcare"
0.731,"9:32:24 PM","orourke","healthcare"
1.47416666666667,"9:36:05 PM","castro","immigration"
1.07983333333333,"9:37:42 PM","booker","immigration"
0.733333333333333,"9:38:46 PM","castro","immigration"
0.416666666666667,"9:39:30 PM","booker","immigration"
1.12083333333333,"9:39:55 PM","deblasio","immigration"
1.10183333333333,"9:41:15 PM","orourke","immigration"
0.611666666666667,"9:42:21 PM","castro","immigration"
0.259666666666667,"9:42:58 PM","orourke","immigration"
0.0406666666666667,"9:43:13 PM","castro","immigration"
0.113166666666667,"9:43:16 PM","orourke","immigration"
0.0381666666666667,"9:43:23 PM","castro","immigration"
0.571666666666667,"9:43:25 PM","castro","immigration"
0.112833333333333,"9:44:14 PM","delaney","immigration"
1.21133333333333,"9:44:42 PM","klobuchar","immigration"
1.13316666666667,"9:46:02 PM","ryan","immigration"
1.034,"9:47:32 PM","booker","immigration"
1.1455,"9:48:44 PM","inslee","immigration"
0.0521666666666667,"9:49:59 PM","delaney","immigration"
0.676166666666667,"9:50:32 PM","booker","foreign policy"
1.163,"9:51:23 PM","klobuchar","foreign policy"
1.10666666666667,"9:52:45 PM","gabbard","foreign policy"
0.497666666666667,"9:53:57 PM","gabbard","foreign policy"
1.15783333333333,"10:06:36 PM","warren","gun"
0.585833333333333,"10:07:51 PM","warren","gun"
1.06816666666667,"10:08:38 PM","booker","gun"
1.09516666666667,"10:10:16 PM","castro","gun"
0.788833333333333,"10:11:26 PM","ryan","gun"
1.11916666666667,"10:12:33 PM","orourke","gun"
0.73,"10:13:56 PM","klobuchar","gun"
1.062,"10:14:59 PM","booker","gun"
1.24466666666667,"10:16:31 PM","deblasio","gun"
0.29,"10:17:28 PM","deblasio","other"
1.2445,"10:18:23 PM","warren","other"
0.973,"10:19:49 PM","delaney","other"
0.678833333333333,"10:21:02 PM","booker","other"
1.18716666666667,"10:22:19 PM","inslee","climate"
1.24,"10:23:53 PM","orourke","climate"
0.988666666666667,"10:25:35 PM","castro","climate"
0.2925,"10:27:06 PM","ryan","climate"
1.12516666666667,"10:27:24 PM","ryan","other"
0.639333333333333,"10:28:38 PM","delaney","climate"
1.015,"10:29:37 PM","gabbard","other"
0.675666666666667,"10:30:38 PM","booker","other"
1.31783333333333,"10:31:48 PM","klobuchar","other"
0.633333333333333,"10:33:28 PM","castro","other"
1.11316666666667,"10:34:42 PM","orourke","foreign policy"
0.964166666666667,"10:35:53 PM","deblasio","foreign policy"
1.17116666666667,"10:37:14 PM","ryan","foreign policy"
0.744666666666667,"10:38:25 PM","gabbard","foreign policy"
0.424333333333333,"10:39:18 PM","ryan","foreign policy"
0.047,"10:39:43 PM","gabbard","foreign policy"
0.061,"10:39:46 PM","ryan","foreign policy"
0.124166666666667,"10:39:50 PM","gabbard","foreign policy"
0.100833333333333,"10:39:57 PM","ryan","foreign policy"
0.049,"10:40:03 PM","gabbard","foreign policy"
0.103166666666667,"10:40:06 PM","ryan","foreign policy"
0.301,"10:40:12 PM","ryan","foreign policy"
0.063,"10:40:30 PM","gabbard","foreign policy"
0.236666666666667,"10:40:44 PM","delaney","statement"
0.184333333333333,"10:40:58 PM","inslee","statement"
0.1245,"10:41:09 PM","gabbard","statement"
0.169833333333333,"10:41:16 PM","klobuchar","statement"
0.0911666666666667,"10:41:27 PM","orourke","statement"
0.0428333333333333,"10:41:32 PM","warren","statement"
0.0545,"10:41:35 PM","booker","statement"
0.0695,"10:41:38 PM","castro","statement"
0.0761666666666667,"10:41:42 PM","ryan","statement"
0.111833333333333,"10:41:47 PM","deblasio","statement"
1.14416666666667,"10:42:30 PM","orourke","trump"
0.832,"10:44:10 PM","delaney","trump"
0.578166666666667,"10:45:00 PM","delaney","economy"
0.150666666666667,"10:45:41 PM","klobuchar",""
1.05683333333333,"10:49:41 PM","delaney","statement"
0.8055,"10:50:51 PM","deblasio","statement"
0.914333333333333,"10:51:45 PM","inslee","statement"
1.04283333333333,"10:52:44 PM","ryan","statement"
0.902,"10:53:51 PM","gabbard","statement"
0.733833333333333,"10:54:50 PM","castro","statement"
0.903833333333333,"10:55:39 PM","klobuchar","statement"
0.923,"10:56:40 PM","booker","statement"
0.882,"10:57:40 PM","orourke","statement"
0.956,"10:58:40 PM","warren","statement"', stringsAsFactors = FALSE) %>% 
  as_tibble() %>% 
  filter(
    !(topic %in% c("closing", "statement", ""))
  ) %>% 
  mutate(topic = ifelse(topic == "gun", "gun control", topic)) %>% 
  mutate(topic = stri_trans_totitle(topic)) -> speaking_times


speaking_times %>% 
  mutate(speaker = stri_trans_totitle(speaker)) %>% 
  mutate(speaker = case_when(
    speaker == "Deblasio" ~ "de Blasio",
    speaker == "Orourke" ~ "O'Rouke",
    TRUE ~ speaker
  )) %>% 
  group_by(speaker) %>% 
  mutate(idx = 1:n()) %>%
  mutate(
    esum = cumsum(elapsed),
    start_pos = esum - elapsed
  ) %>% 
  ungroup() %>% 
  { .ordr <<- count(., speaker, wt=elapsed, sort=TRUE) ; . } %>% 
  mutate(
    speaker = factor(speaker, levels = rev(.ordr$speaker))
  ) %>% 
  ggplot() +
  geom_chicklet(
    aes(speaker, elapsed, group = idx, fill = topic),
    position = position_stack(reverse=TRUE),
    radius = unit(3, "pt"), 
    width = 0.6, color = "white"
  ) +
  coord_flip() +
  ggthemes::scale_fill_tableau("Tableau 20") +
  scale_x_discrete(expand = c(0, 0.5)) +
  scale_y_continuous(
    expand = c(0, 0.0625), 
    position = "right",
    breaks = seq(0, 14, 2),
    labels = c(0, sprintf("%d min.", seq(2, 14, 2)))
  ) +
  labs(
    x = NULL, y = NULL, fill = NULL,
    title = "How Long Each Candidate Spoke",
    subtitle = "Nights 1 & 2 of the June 2019 Democratic Debates",
    caption = "Originals <https://www.nytimes.com/interactive/2019/admin/100000006581096.embedded.html?>\n<https://www.nytimes.com/interactive/2019/admin/100000006584572.embedded.html?>\nby @nytimes Weiyi Cai, Jason Kao, Jasmine C. Lee, Alicia Parlapiano and Jugal K. Patel\nEach bar segment represents the length of a candidate’s response to a question.\n#rstats reproduction by @hrbrmstr"
  ) +
  theme_ipsum_rc(grid="") +
  theme(axis.text.x = element_text(color = "gray60", size = 9)) +
  theme(axis.ticks = element_line(color = "gray60", size = 0.15)) +
  theme(axis.ticks.x = element_line(color = "gray0", size = 0.15)) +
  theme(axis.ticks.length = grid::unit(5, "pt")) +
  theme(axis.ticks.length.x = grid::unit(5, "pt")) +
  theme(legend.position = "bottom")
```

<img src="README_files/figure-gfm/unnamed-chunk-1-1.png" width="100%" />

## ggchicklet Metrics

| Lang | \# Files |  (%) | LoC |  (%) | Blank lines |  (%) | \# Lines |  (%) |
| :--- | -------: | ---: | --: | ---: | ----------: | ---: | -------: | ---: |
| Rmd  |        1 | 0.14 | 303 | 0.77 |          22 | 0.54 |       36 | 0.46 |
| R    |        6 | 0.86 |  89 | 0.23 |          19 | 0.46 |       42 | 0.54 |

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
