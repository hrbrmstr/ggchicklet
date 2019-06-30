## code to prepare `debates2019` dataset goes here

read_csv(
  file = "https://rud.is/data/2019-dem-debates.csv.gz",
  col_types = cols(
    elapsed = col_double(),
    timestamp = col_time(format = ""),
    speaker = col_character(),
    topic = col_character()
  )
) -> debates2019


usethis::use_data(debates2019, overwrite = TRUE)
