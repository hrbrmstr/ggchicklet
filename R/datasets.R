#' @md
#' @title 2019-2020 U.S. Democratic Debate Candidate/Topic Times
#' @description The New York Times and other media outlets kept track of the time each
#'              candidate spent talking including the timestamp of the start of the blathering
#'              and the topic up for debate. This dataset only includes candidates and
#'              topic times. The complete datasets (See References) also include moderator
#'              metadata and opening/closing statement records.
#' @format data frame with columns: `elapsed` (dbl), `timestamp` (time), `speaker` (chr), `topic` (chr)
#'         `debate_date` (date), `debate_group` (dbl), `night` (dbl)
#' @docType data
#' @keywords datasets
#' @name debates2019
#' @references <https://www.nytimes.com/interactive/2019/06/26/us/elections/debate-speaking-time.html>
#' @references <https://www.nytimes.com/interactive/2019/06/27/us/elections/debate-speaking-time.html>
#' @references <https://www.nytimes.com/interactive/2019/07/30/us/elections/debate-speaking-time.html>
#' @references <https://www.nytimes.com/interactive/2019/07/31/us/elections/debate-speaking-time.html>
#' @references <https://www.nytimes.com/interactive/2019/09/12/us/elections/debate-speaking-time.html>
#' @references <https://www.nytimes.com/interactive/2019/10/15/us/elections/debate-speaking-time.html>
#' @usage data("debates2019")
NULL