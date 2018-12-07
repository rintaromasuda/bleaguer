#' @export
ConvertMinStrToDec <- function(min_str)
{
  Convert <- function(item) {
    min <- as.numeric(item[1])
    min <- min + as.numeric(item[2]) / 60
    round(min, 2)
  }

  ls <- sapply(stringr::str_split(min_str, ":"), Convert)
  return(ls)
}

