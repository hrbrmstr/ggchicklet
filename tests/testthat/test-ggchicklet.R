library(ggplot2)

context("chicklet geoms are created properly")
test_that("chicklet geoms are created properly", {

  data("debates2019")

  spkr_ordr <- aggregate(elapsed ~ speaker, data = debates2019, sum)
  spkr_ordr <- spkr_ordr[order(spkr_ordr[["elapsed"]]),]

  debates2019$speaker <- factor(debates2019$speaker, spkr_ordr$speaker)

  ggplot(debates2019) +
  geom_chicklet(aes(speaker, elapsed, group = timestamp, fill = topic)) -> gg

  print(gg)

  ggplot_build(gg) -> gb

  ggplot_gtable(gb) -> gt

  expect_true(all(c("GeomChicklet", "GeomRrect") %in% class(gb$plot$layers[[1]]$geom)))


})
