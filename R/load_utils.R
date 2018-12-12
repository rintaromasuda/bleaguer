#' @export
LoadTeams <- function()
{
  file <- system.file("extdata", "teams.csv", package = "bleaguer", mustWork = TRUE)
  df <- readr::read_csv(file, locale = readr::locale(encoding = "UTF-8"))

  return(df)
}

# Objects that get loaded by default when this package gets loaded
b.teams <- LoadTeams()
