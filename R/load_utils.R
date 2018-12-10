#' @export
LoadTeams <- function()
{
  file <- system.file("extdata", "teams.csv", package = "bleaguer", mustWork = TRUE)
  df <- read.csv(file, encoding = "UTF-8", sep = ",")

  return(df)
}

teams <- LoadTeams()
