## code to prepare `debates2019` dataset goes here

# read_csv(
#   file = "https://rud.is/data/2019-dem-debates.csv.gz",
#   col_types = cols(
#     elapsed = col_double(),
#     timestamp = col_time(format = ""),
#     speaker = col_character(),
#     topic = col_character()
#   )
# ) -> debates2019
#
#
# usethis::use_data(debates2019, overwrite = TRUE)
library(rvest)
library(stringi)
library(tidyverse)

if (!file.exists(here::here("data-raw/2019-06-26-us-elections-debate-speaking-time.html"))) download.file("https://www.nytimes.com/interactive/2019/06/26/us/elections/debate-speaking-time.html", here::here("data-raw/2019-06-26-us-elections-debate-speaking-time.html"))
if (!file.exists(here::here("data-raw/2019-06-27-us-elections-debate-speaking-time.html"))) download.file("https://www.nytimes.com/interactive/2019/06/27/us/elections/debate-speaking-time.html", here::here("data-raw/2019-06-27-us-elections-debate-speaking-time.html"))
if (!file.exists(here::here("data-raw/2019-07-30-us-elections-debate-speaking-time.html"))) download.file("https://www.nytimes.com/interactive/2019/07/30/us/elections/debate-speaking-time.html", here::here("data-raw/2019-07-30-us-elections-debate-speaking-time.html"))
if (!file.exists(here::here("data-raw/2019-07-31-us-elections-debate-speaking-time.html"))) download.file("https://www.nytimes.com/interactive/2019/07/31/us/elections/debate-speaking-time.html", here::here("data-raw/2019-07-31-us-elections-debate-speaking-time.html"))
if (!file.exists(here::here("data-raw/2019-09-12-us-elections-debate-speaking-time.html"))) download.file("https://www.nytimes.com/interactive/2019/09/12/us/elections/debate-speaking-time.html", here::here("data-raw/2019-09-12-us-elections-debate-speaking-time.html"))
if (!file.exists(here::here("data-raw/2019-10-15-us-elections-debate-speaking-time.html"))) download.file("https://www.nytimes.com/interactive/2019/10/15/us/elections/debate-speaking-time.html", here::here("data-raw/2019-10-15-us-elections-debate-speaking-time.html"))
if (!file.exists(here::here("data-raw/2019-11-20-us-elections-debate-speaking-time.html"))) download.file("https://www.nytimes.com/interactive/2019/11/20/us/elections/debate-speaking-time.html", here::here("data-raw/2019-11-20-us-elections-debate-speaking-time.html"))
if (!file.exists(here::here("data-raw/2019-12-19-us-elections-debate-speaking-time.html"))) download.file("https://www.nytimes.com/interactive/2019/12/19/us/elections/debate-speaking-time.html", here::here("data-raw/2019-12-19-us-elections-debate-speaking-time.html"))
if (!file.exists(here::here("data-raw/2020-01-14-us-elections-debate-speaking-time.html"))) download.file("https://www.nytimes.com/interactive/2020/01/14/us/politics/debate-speaking-time.html",  here::here("data-raw/2020-01-14-us-elections-debate-speaking-time.html"))
if (!file.exists(here::here("data-raw/2020-02-07-us-elections-debate-speaking-time.html"))) download.file("https://www.nytimes.com/interactive/2020/02/07/us/elections/debate-speaking-time.html", here::here("data-raw/2020-02-07-us-elections-debate-speaking-time.html"))
if (!file.exists(here::here("data-raw/2020-02-19-us-elections-debate-speaking-time.html"))) download.file("https://www.nytimes.com/interactive/2020/02/19/us/elections/debate-speaking-time.html", here::here("data-raw/2020-02-19-us-elections-debate-speaking-time.html"))

read_html(here::here("data-raw/2019-06-26-us-elections-debate-speaking-time.html")) %>%
  html_nodes(xpath = ".//script[contains(., 'NYTG_DEMDEBATES')]") %>%
  html_text() %>%
  stri_split_lines() %>%
  unlist() %>%
  .[3] %>%
  stri_replace_first_regex("^.*NYTG_DEMDEBATES = ", "") %>%
  jsonlite::fromJSON() %>%
  mutate(
    elapsed = as.numeric(elapsed)/60,
    debate_date = as.Date("2019-09-13"),
    speaker = stri_trans_totitle(speaker),
    timestamp = parse_time(timestamp),
    topic = stri_trans_totitle(topic),
    debate_group = 1,
    night = 1
  ) %>%
  mutate(
    speaker = case_when(
      speaker == "Orourke" ~ "O'Rourke",
      speaker == "Deblasio" ~ "de Blasio",
      TRUE ~ speaker
    )
  ) %>%
  mutate(
    topic = case_when(
      topic == "" ~ "Other",
      grepl("Campaign", topic) ~ "Campaign Finance Reform",
      grepl("Civil", topic) ~ "Civil Rights",
      grepl("Climate", topic) ~ "Climate",
      grepl("Foreign", topic) ~ "Foreign Policy",
      grepl("Gun", topic) ~ "Gun Control",
      grepl("Election", topic) ~ "Elections Reform",
      grepl("Health", topic) ~ "Healthcare",
      grepl("Party", topic) ~ "Party Strategy",
      grepl("Women", topic) ~ "Women's Rights",
      TRUE ~ topic
    )
  ) %>%
  filter(
    !is.na(timestamp),
    speaker != "",
    speaker != "Moderator"
  ) %>%
  as_tibble() -> jun_day_1

read_html(here::here("data-raw/2019-06-27-us-elections-debate-speaking-time.html")) %>%
  html_nodes(xpath = ".//script[contains(., 'NYTG_DEMDEBATES')]") %>%
  html_text() %>%
  stri_split_lines() %>%
  unlist() %>%
  .[3] %>%
  stri_replace_first_regex("^.*NYTG_DEMDEBATES = ", "") %>%
  jsonlite::fromJSON() %>%
  mutate(
    elapsed = as.numeric(elapsed)/60,
    debate_date = as.Date("2019-09-13"),
    speaker = stri_trans_totitle(speaker),
    timestamp = parse_time(timestamp),
    topic = stri_trans_totitle(topic),
    debate_group = 1,
    night = 2
  ) %>%
  mutate(
    speaker = case_when(
      speaker == "Orourke" ~ "O'Rourke",
      speaker == "Deblasio" ~ "de Blasio",
      TRUE ~ speaker
    )
  ) %>%
  mutate(
    topic = case_when(
      topic == "" ~ "Other",
      grepl("Campaign", topic) ~ "Campaign Finance Reform",
      grepl("Civil", topic) ~ "Civil Rights",
      grepl("Climate", topic) ~ "Climate",
      grepl("Foreign", topic) ~ "Foreign Policy",
      grepl("Gun", topic) ~ "Gun Control",
      grepl("Election", topic) ~ "Elections Reform",
      grepl("Health", topic) ~ "Healthcare",
      grepl("Party", topic) ~ "Party Strategy",
      grepl("Women", topic) ~ "Women's Rights",
      TRUE ~ topic
    )
  ) %>%
  filter(
    !is.na(timestamp),
    speaker != "",
    speaker != "Moderator"
  ) %>%
  as_tibble() -> jun_day_2

read_html(here::here("data-raw/2019-07-30-us-elections-debate-speaking-time.html")) %>%
  html_nodes(xpath = ".//script[contains(., 'NYTG_DEMDEBATES')]") %>%
  html_text() %>%
  stri_split_lines() %>%
  unlist() %>%
  .[2] %>%
  stri_replace_first_regex("^.*NYTG_DEMDEBATES = ", "") %>%
  jsonlite::fromJSON() %>%
  mutate(
    elapsed = as.numeric(elapsed)/60,
    debate_date = as.Date("2019-09-13"),
    speaker = stri_trans_totitle(speaker),
    timestamp = parse_time(timestamp),
    topic = stri_trans_totitle(topic),
    debate_group = 2,
    night = 1
  ) %>%
  mutate(
    speaker = case_when(
      speaker == "Orourke" ~ "O'Rourke",
      speaker == "Deblasio" ~ "de Blasio",
      TRUE ~ speaker
    )
  ) %>%
  mutate(
    topic = case_when(
      topic == "" ~ "Other",
      grepl("Campaign", topic) ~ "Campaign Finance Reform",
      grepl("Civil", topic) ~ "Civil Rights",
      grepl("Climate", topic) ~ "Climate",
      grepl("Foreign", topic) ~ "Foreign Policy",
      grepl("Gun", topic) ~ "Gun Control",
      grepl("Election", topic) ~ "Elections Reform",
      grepl("Health", topic) ~ "Healthcare",
      grepl("Party", topic) ~ "Party Strategy",
      grepl("Women", topic) ~ "Women's Rights",
      TRUE ~ topic
    )
  ) %>%
  filter(
    !is.na(timestamp),
    speaker != "",
    speaker != "Moderator"
  ) %>%
  as_tibble() -> jul_day_1

read_html(here::here("data-raw/2019-07-31-us-elections-debate-speaking-time.html")) %>%
  html_nodes(xpath = ".//script[contains(., 'NYTG_DEMDEBATES')]") %>%
  html_text() %>%
  stri_split_lines() %>%
  unlist() %>%
  .[2] %>%
  stri_replace_first_regex("^.*NYTG_DEMDEBATES = ", "") %>%
  jsonlite::fromJSON() %>%
  mutate(
    elapsed = as.numeric(elapsed)/60,
    debate_date = as.Date("2019-09-13"),
    speaker = stri_trans_totitle(speaker),
    timestamp = parse_time(timestamp),
    topic = stri_trans_totitle(topic),
    debate_group = 2,
    night = 2
  ) %>%
  mutate(
    speaker = case_when(
      speaker == "Orourke" ~ "O'Rourke",
      speaker == "Deblasio" ~ "de Blasio",
      TRUE ~ speaker
    )
  ) %>%
  mutate(
    topic = case_when(
      topic == "" ~ "Other",
      grepl("Campaign", topic) ~ "Campaign Finance Reform",
      grepl("Civil", topic) ~ "Civil Rights",
      grepl("Climate", topic) ~ "Climate",
      grepl("Foreign", topic) ~ "Foreign Policy",
      grepl("Gun", topic) ~ "Gun Control",
      grepl("Election", topic) ~ "Elections Reform",
      grepl("Health", topic) ~ "Healthcare",
      grepl("Party", topic) ~ "Party Strategy",
      grepl("Women", topic) ~ "Women's Rights",
      TRUE ~ topic
    )
  ) %>%
  filter(
    !is.na(timestamp),
    speaker != "",
    speaker != "Moderator"
  ) %>%
  as_tibble() -> jul_day_2

read_html(here::here("data-raw/2019-09-12-us-elections-debate-speaking-time.html")) %>%
  html_nodes(xpath = ".//script[contains(., 'NYTG_DEMDEBATES')]") %>%
  html_text() %>%
  stri_split_lines() %>%
  unlist() %>%
  .[3] %>%
  stri_replace_first_regex("^.*NYTG_DEMDEBATES = ", "") %>%
  jsonlite::fromJSON() %>%
  mutate(
    elapsed = as.numeric(elapsed)/60,
    debate_date = as.Date("2019-09-13"),
    speaker = stri_trans_totitle(speaker),
    timestamp = parse_time(timestamp),
    topic = stri_trans_totitle(topic),
    debate_group = 3,
    night = 1
  ) %>%
  mutate(
    speaker = case_when(
      speaker == "Orourke" ~ "O'Rourke",
      speaker == "Deblasio" ~ "de Blasio",
      TRUE ~ speaker
    )
  ) %>%
  mutate(
    topic = case_when(
      topic == "" ~ "Other",
      grepl("Campaign", topic) ~ "Campaign Finance Reform",
      grepl("Civil", topic) ~ "Civil Rights",
      grepl("Climate", topic) ~ "Climate",
      grepl("Foreign", topic) ~ "Foreign Policy",
      grepl("Gun", topic) ~ "Gun Control",
      grepl("Election", topic) ~ "Elections Reform",
      grepl("Health", topic) ~ "Healthcare",
      grepl("Party", topic) ~ "Party Strategy",
      grepl("Women", topic) ~ "Women's Rights",
      TRUE ~ topic
    )
  ) %>%
  filter(
    !is.na(timestamp),
    speaker != "",
    speaker != "Moderator"
  ) %>%
  as_tibble() -> sep_day_1

read_html(here::here("data-raw/2019-10-15-us-elections-debate-speaking-time.html")) %>%
  html_nodes(xpath = ".//script[contains(., 'NYTG_DEMDEBATES')]") %>%
  html_text() %>%
  stri_split_lines() %>%
  unlist() %>%
  .[3] %>%
  stri_replace_first_regex("^.*NYTG_DEMDEBATES = ", "") %>%
  jsonlite::fromJSON() %>%
  mutate(
    elapsed = as.numeric(elapsed)/60,
    debate_date = as.Date("2019-10-15"),
    speaker = stri_trans_totitle(speaker),
    timestamp = parse_time(timestamp),
    debate_group = 4,
    night = 1
  ) %>%
  mutate(
    speaker = case_when(
      speaker == "Orourke" ~ "O'Rourke",
      TRUE ~ speaker
    )
  ) %>%
  mutate(
    topic = case_when(
      topic == "" ~ "Other",
      grepl("impeachment", topic) ~ "Impeachment",
      grepl("economy", topic) ~ "Economy",
      grepl("opioids", topic) ~ "Opioids",
      grepl("candidate-age", topic) ~ "Age",
      grepl("tech-companies", topic) ~ "Tech Companies",
      grepl("middle-east policy", topic) ~ "Foreign Policy",
      grepl("gun-control", topic) ~ "Gun Control",
      grepl("income-inequality", topic) ~ "Income Inequality",
      grepl("health-care", topic) ~ "Healthcare",
      grepl("party-strategy", topic) ~ "Party Strategy",
      grepl("womens-rights", topic) ~ "Women's Rights",
      TRUE ~ topic
    )
  ) %>%
  filter(
    !is.na(timestamp),
    speaker != "",
    speaker != "Moderator"
  ) %>%
  as_tibble() -> oct_day_1

read_html(here::here("data-raw/2019-11-20-us-elections-debate-speaking-time.html")) %>%
  html_nodes(xpath = ".//script[contains(., 'NYTG_DEMDEBATES')]") %>%
  html_text() %>%
  stri_split_lines() %>%
  unlist() %>%
  .[3] %>%
  stri_replace_first_regex("^.*NYTG_DEMDEBATES = ", "") %>%
  jsonlite::fromJSON() %>%
  as_tibble() %>%
  mutate(
    elapsed = as.numeric(elapsed)/60,
    debate_date = as.Date("2019-11-20"),
    speaker = stri_trans_totitle(speaker),
    timestamp = parse_time(timestamp),
    debate_group = 5,
    night = 1
  ) %>%
  filter(speaker != "") %>%
  mutate(
    topic = case_when(
      topic == "" & speaker == "Biden" ~ "Closing",
      grepl("climate", topic) ~ "Climate",
      grepl("closing", topic) ~ "Closing",
      grepl("criminal-justice", topic) ~ "Criminal Justice",
      grepl("electability", topic) ~ "Electability",
      grepl("election-reform", topic) ~ "Election Reform",
      grepl("executive-power", topic) ~ "Executive Power",
      grepl("candidate-age", topic) ~ "Age",
      grepl("foreign-policy", topic) ~ "Foreign Policy",
      grepl("gun-control", topic) ~ "Gun Control",
      grepl("health-care", topic) ~ "Healthcare",
      grepl("immigration", topic) ~ "Immigration",
      grepl("impeachment", topic) ~ "Impeachment",
      grepl("income-inequality", topic) ~ "Income Inequality",
      grepl("economic-inequality", topic) ~ "Income Inequality",
      grepl("economy", topic) ~ "Economy",
      grepl("middle-east policy", topic) ~ "Foreign Policy",
      grepl("opioids", topic) ~ "Opioids",
      grepl("party-strategy", topic) ~ "Party Strategy",
      grepl("public-service", topic) ~ "Public Service",
      grepl("tech-companies", topic) ~ "Tech Companies",
      grepl("white-supremacist violence", topic) ~ "White-Supremacy",
      grepl("womens-issues", topic) ~ "Women's Rights",
      topic == "" ~ "Other",
      TRUE ~ topic
    )
  ) %>%
  filter(
    !is.na(timestamp),
    speaker != "",
    speaker != "Moderator"
  ) %>%
  as_tibble() -> nov_day_1

read_html(here::here("data-raw/2019-12-19-us-elections-debate-speaking-time.html")) %>%
  html_nodes(xpath = ".//script[contains(., 'NYTG_DEMDEBATES')]") %>%
  html_text() %>%
  stri_split_lines() %>%
  unlist() %>%
  .[3] %>%
  stri_replace_first_regex("^.*NYTG_DEMDEBATES = ", "") %>%
  jsonlite::fromJSON() %>%
  as_tibble() %>%
  mutate(
    elapsed = as.numeric(elapsed)/60,
    debate_date = as.Date("2019-12-19"),
    speaker = stri_trans_totitle(speaker),
    timestamp = parse_time(timestamp),
    debate_group = 6,
    night = 1
  ) %>%
  filter(speaker != "") %>%
  mutate(
    topic = case_when(
      topic == "" ~ "Other",
      grepl("climate", topic) ~ "Climate",
      grepl("closing", topic) ~ "Closing",
      grepl("judges", topic) ~ "Judges",
      grepl("transparency", topic) ~ "Transparency",
      grepl("race", topic) ~ "Race",
      grepl("economic-inequality", topic) ~ "Income Inequality",
      grepl("education", topic) ~ "Education",
      grepl("human-rights", topic) ~ "Human Rights",
      grepl("criminal-justice", topic) ~ "Criminal Justice",
      grepl("electability", topic) ~ "Electability",
      grepl("election-reform", topic) ~ "Election Reform",
      grepl("executive-power", topic) ~ "Executive Power",
      grepl("candidate-age", topic) ~ "Age",
      grepl("foreign-policy", topic) ~ "Foreign Policy",
      grepl("gun-control", topic) ~ "Gun Control",
      grepl("health-care", topic) ~ "Healthcare",
      grepl("immigration", topic) ~ "Immigration",
      grepl("impeachment", topic) ~ "Impeachment",
      grepl("income-inequality", topic) ~ "Income Inequality",
      grepl("economy", topic) ~ "Economy",
      grepl("middle-east policy", topic) ~ "Foreign Policy",
      grepl("opioids", topic) ~ "Opioids",
      grepl("party-strategy", topic) ~ "Party Strategy",
      grepl("public-service", topic) ~ "Public Service",
      grepl("tech-companies", topic) ~ "Tech Companies",
      grepl("white-supremacist violence", topic) ~ "White-Supremacy",
      grepl("womens-issues", topic) ~ "Women's Rights",
      topic == "" ~ "Other",
      TRUE ~ topic
    )
  ) %>%
  filter(
    !is.na(timestamp),
    speaker != "",
    speaker != "Moderator"
  ) %>%
  as_tibble() -> dec_day_1

read_html(here::here("data-raw/2020-01-14-us-elections-debate-speaking-time.html")) %>%
  html_nodes(xpath = ".//script[contains(., 'NYTG_DEMDEBATES')]") %>%
  html_text() %>%
  stri_split_lines() %>%
  unlist() %>%
  .[3] %>%
  stri_replace_first_regex("^.*NYTG_DEMDEBATES = ", "") %>%
  jsonlite::fromJSON() %>%
  as_tibble() %>%
  mutate(
    elapsed = as.numeric(elapsed)/60,
    debate_date = as.Date("2020-01-14"),
    speaker = stri_trans_totitle(speaker),
    timestamp = parse_time(timestamp),
    debate_group = 7,
    night = 1
  ) %>%
  filter(speaker != "") %>%
  mutate(
    topic = case_when(
      topic == "" ~ "Other",
      grepl("military", topic) ~ "Military",
      grepl("climate", topic) ~ "Climate",
      grepl("closing", topic) ~ "Closing",
      grepl("judges", topic) ~ "Judges",
      grepl("race", topic) ~ "Race",
      grepl("education", topic) ~ "Education",
      grepl("human-rights", topic) ~ "Human Rights",
      grepl("criminal-justice", topic) ~ "Criminal Justice",
      grepl("electability", topic) ~ "Electability",
      grepl("election-reform", topic) ~ "Election Reform",
      grepl("executive-power", topic) ~ "Executive Power",
      grepl("candidate-age", topic) ~ "Age",
      grepl("foreign-policy", topic) ~ "Foreign Policy",
      grepl("gun-control", topic) ~ "Gun Control",
      grepl("child-care", topic) ~ "Child Care",
      grepl("health-care", topic) ~ "Healthcare",
      grepl("immigration", topic) ~ "Immigration",
      grepl("impeachment", topic) ~ "Impeachment",
      grepl("income-inequality", topic) ~ "Income Inequality",
      grepl("female-president", topic) ~ "Female President",
      grepl("trade", topic) ~ "Trade",
      grepl("economy", topic) ~ "Economy",
      grepl("middle-east policy", topic) ~ "Foreign Policy",
      grepl("opioids", topic) ~ "Opioids",
      grepl("party-strategy", topic) ~ "Party Strategy",
      grepl("public-service", topic) ~ "Public Service",
      grepl("tech-companies", topic) ~ "Tech Companies",
      grepl("white-supremacist violence", topic) ~ "White-Supremacy",
      grepl("womens-issues", topic) ~ "Women's Rights",
      topic == "" ~ "Other",
      TRUE ~ topic
    )
  ) %>%
  filter(
    !is.na(timestamp),
    speaker != "",
    speaker != "Moderator"
  ) %>%
  as_tibble() -> jan_20_day_1


read_html(here::here("data-raw/2020-02-07-us-elections-debate-speaking-time.html")) %>%
  html_nodes(xpath = ".//script[contains(., 'NYTG_DEMDEBATES')]") %>%
  html_text() %>%
  stri_split_lines() %>%
  unlist() %>%
  .[3] %>%
  stri_replace_first_regex("^.*NYTG_DEMDEBATES = ", "") %>%
  jsonlite::fromJSON() %>%
  as_tibble() %>%
  mutate(
    elapsed = as.numeric(elapsed)/60,
    debate_date = as.Date("2020-01-14"),
    speaker = stri_trans_totitle(speaker),
    timestamp = parse_time(timestamp),
    debate_group = 8,
    night = 1
  ) %>%
  filter(speaker != "") %>%
  filter(!is.na(timestamp)) %>%
  mutate(
    topic = case_when(
      topic == "" ~ "Other",
      grepl("military", topic) ~ "Military",
      grepl("climate", topic) ~ "Climate",
      grepl("closing", topic) ~ "Closing",
      grepl("judges", topic) ~ "Judges",
      grepl("race", topic) ~ "Race",
      grepl("Climate-change", topic) ~ "Climate",
      grepl("poverty", topic) ~ "Poverty",
      grepl("education", topic) ~ "Education",
      grepl("bloomberg", topic) ~ "Bloomberg",
      grepl("human-rights", topic) ~ "Human Rights",
      grepl("criminal-justice", topic) ~ "Criminal Justice",
      grepl("electability", topic) ~ "Electability",
      grepl("election-reform", topic) ~ "Election Reform",
      grepl("executive-power", topic) ~ "Executive Power",
      grepl("candidate-age", topic) ~ "Age",
      grepl("supreme-court", topic) ~ "Supreme Court",
      grepl("foreign-policy", topic) ~ "Foreign Policy",
      grepl("gun-control", topic) ~ "Gun Control",
      grepl("child-care", topic) ~ "Child Care",
      grepl("health-care", topic) ~ "Healthcare",
      grepl("immigration", topic) ~ "Immigration",
      grepl("impeachment", topic) ~ "Impeachment",
      grepl("income-inequality", topic) ~ "Income Inequality",
      grepl("female-president", topic) ~ "Female President",
      grepl("trade", topic) ~ "Trade",
      grepl("economy", topic) ~ "Economy",
      grepl("middle-east policy", topic) ~ "Foreign Policy",
      grepl("opioids", topic) ~ "Opioids",
      grepl("party-strategy", topic) ~ "Party Strategy",
      grepl("public-service", topic) ~ "Public Service",
      grepl("tech-companies", topic) ~ "Tech Companies",
      grepl("white-supremacist violence", topic) ~ "White-Supremacy",
      grepl("womens-issues", topic) ~ "Women's Rights",
      topic == "" ~ "Other",
      TRUE ~ topic
    )
  ) %>%
  filter(
    !is.na(timestamp),
    speaker != "",
    speaker != "Moderator"
  ) %>%
  as_tibble() -> feb_07_day_1


read_html(here::here("data-raw/2020-02-19-us-elections-debate-speaking-time.html")) %>%
  html_nodes(xpath = ".//script[contains(., 'NYTG_DEMDEBATES')]") %>%
  html_text() %>%
  stri_split_lines() %>%
  unlist() %>%
  .[3] %>%
  stri_replace_first_regex("^.*NYTG_DEMDEBATES = ", "") %>%
  jsonlite::fromJSON() %>%
  as_tibble() %>%
  mutate(
    elapsed = as.numeric(elapsed)/60,
    debate_date = as.Date("2020-01-14"),
    speaker = stri_trans_totitle(speaker),
    timestamp = parse_time(timestamp),
    debate_group = 9,
    night = 1
  ) %>%
  filter(speaker != "") %>%
  filter(!is.na(timestamp)) %>%
  # distinct(topic) %>%
  # print(n=nrow(.))
  mutate(
    topic = case_when(
      topic == "" ~ "Other",
      grepl("military", topic) ~ "Military",
      grepl("climate", topic) ~ "Climate",
      grepl("closing", topic) ~ "Closing",
      grepl("judges", topic) ~ "Judges",
      grepl("race", topic) ~ "Race",
      grepl("Climate-change", topic) ~ "Climate",
      grepl("poverty", topic) ~ "Poverty",
      grepl("education", topic) ~ "Education",
      grepl("bloomberg", topic) ~ "Bloomberg",
      grepl("human-rights", topic) ~ "Human Rights",
      grepl("criminal-justice", topic) ~ "Criminal Justice",
      grepl("electability", topic) ~ "Electability",
      grepl("election-reform", topic) ~ "Election Reform",
      grepl("executive-power", topic) ~ "Executive Power",
      grepl("candidate-age", topic) ~ "Age",
      grepl("supreme-court", topic) ~ "Supreme Court",
      grepl("foreign-policy", topic) ~ "Foreign Policy",
      grepl("gun-control", topic) ~ "Gun Control",
      grepl("child-care", topic) ~ "Child Care",
      grepl("party-loyalty", topic) ~ "Party Loyalty",
      grepl("health-care", topic) ~ "Healthcare",
      grepl("immigration", topic) ~ "Immigration",
      grepl("impeachment", topic) ~ "Impeachment",
      grepl("economic-inequality", topic) ~ "Income Inequality",
      grepl("income-inequality", topic) ~ "Income Inequality",
      grepl("female-president", topic) ~ "Female President",
      grepl("trade", topic) ~ "Trade",
      grepl("economy", topic) ~ "Economy",
      grepl("sexism", topic) ~ "Sexism",
      grepl("middle-east policy", topic) ~ "Foreign Policy",
      grepl("opioids", topic) ~ "Opioids",
      grepl("party-strategy", topic) ~ "Party Strategy",
      grepl("public-service", topic) ~ "Public Service",
      grepl("tech-companies", topic) ~ "Tech Companies",
      grepl("white-supremacist violence", topic) ~ "White-Supremacy",
      grepl("womens-issues", topic) ~ "Women's Rights",
      topic == "" ~ "Other",
      TRUE ~ topic
    )
  ) %>%
  filter(
    !is.na(timestamp),
    speaker != "",
    speaker != "Moderator"
  ) %>%
  as_tibble() -> feb_19_day_1


bind_rows(
  jun_day_1,
  jun_day_2,
  jul_day_1,
  jul_day_2,
  sep_day_1,
  oct_day_1,
  nov_day_1,
  dec_day_1,
  jan_20_day_1,
  feb_07_day_1,
  feb_19_day_1
) %>%
  mutate(topic = case_when(
    grepl("elect.*form", topic, ignore.case = TRUE) ~ "Election Reform",
    TRUE ~ topic
  )) -> debates2019

usethis::use_data(debates2019, overwrite = TRUE)

