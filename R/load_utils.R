#' @export
LoadTeams <- function() {
  file <- system.file("extdata", "teams.csv", package = "bleaguer", mustWork = TRUE)
  df <- readr::read_csv(file, locale = readr::locale(encoding = "UTF-8"))

  return(df)
}

LoadEvents <- function() {
  col_names <- c("EventId", "Name")
  events <- c(
    list(2, "B1RS"),
    list(3, "B1CS"),
    list(4, "B1ZPF"),
    list(5, "B1B2AS"),
    list(7, "B2RS"),
    list(8, "B2PF"),
    list(9, "B2ZPF"),
    list(11, "B1B2SW"),
    list(17, "B2B3SW"),
    list(22, "B1B2EC")
    )
  m <- matrix(events, nrow = length(events), ncol = length(col_names), byrow = TRUE)
  df <- as.data.frame(m, stringsAsFactors = TRUE)
  colnames(df) <- col_names
  return(df)
}

# Objects that get loaded by default when this package gets loaded
b.teams <- LoadTeams()
b.events <- LoadEvents()
