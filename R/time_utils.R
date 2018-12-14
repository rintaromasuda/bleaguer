#' @export
ConvertMinStrToDec <- function(min_str) {
  Convert <- function(item) {
    min <- as.numeric(item[1])
    min <- min + as.numeric(item[2]) / 60
    round(min, 2)
  }

  ls <- sapply(stringr::str_split(min_str, ":"), Convert)
  return(ls)
}

#' @export
GetFullDateString <- function(dateString, season) {
  list <- stringr::str_split(dateString, "\\.")
  month <- as.numeric(sapply(list, '[[', 1)) # Get only the month parts
  isStartYear <- month >= 9 & month <= 12
  isOneDigitMonth <- month >= 1 & month <= 9
  startYear <- as.numeric(substr(season, 0, 4)) # Get the start year of the seasons
  actualYear <- ifelse(isStartYear, startYear, startYear + 1)
  result <- paste(as.character(actualYear),
                  ".",
                  ifelse(isOneDigitMonth, "0", ""),
                  dateString,
                  sep = "")
  return(result)
}
