#' @export
LoadTeams <- function()
{
  file <- system.file("extdata", "teams.csv", package = "bleaguer", mustWork = TRUE)
  df <- read_csv(file, locale = locale(encoding = "UTF-8"))

  return(df)
}

teams <- LoadTeams()
