`%l0%` <- function(x, y) if (length(x) == 0) y else x
`%||%` <- function(x, y) if (is.null(x)) y else x
`%@%` <- function(x, name) attr(x, name, exact = TRUE)
`%nin%` <- function(x, table)  match(x, table, nomatch = 0) == 0
