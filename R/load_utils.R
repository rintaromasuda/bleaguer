#' @export
LoadTeams <- function() {
  file <- system.file("extdata", "teams.csv", package = "bleaguer", mustWork = TRUE)
  df <- readr::read_csv(file,
                        col_types = list(
                          readr::col_integer(),
                          readr::col_factor(),
                          readr::col_factor(),
                          readr::col_factor(),
                          readr::col_factor(),
                          readr::col_factor()
                        ),
                        locale = readr::locale(encoding = "UTF-8"))

  return(df)
}

LoadEvents <- function() {
  file <- system.file("extdata", "events.csv", package = "bleaguer", mustWork = TRUE)
  df <- readr::read_csv(file,
                        col_types = list(
                          readr::col_integer(),
                          readr::col_factor(),
                          readr::col_factor(),
                          readr::col_character()
                        ),
                        locale = readr::locale(encoding = "UTF-8"))

  return(df)
}

#' @export
LoadGames <- function() {
  colTypes <- list(
    readr::col_integer(),
    readr::col_factor(),
    readr::col_integer(),
    readr::col_date(format = "%Y.%m.%d"),
    readr::col_factor(),
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer()
  )

  file <- system.file("extdata", "games_201617.csv", package = "bleaguer", mustWork = TRUE)
  df <- readr::read_csv(file,
                        col_types = colTypes,
                        locale = readr::locale(encoding = "UTF-8"))
  result <- df

  file <- system.file("extdata", "games_201718.csv", package = "bleaguer", mustWork = TRUE)
  df <- readr::read_csv(file,
                        col_types = colTypes,
                        locale = readr::locale(encoding = "UTF-8"))
  result <- rbind(result, df)

  file <- system.file("extdata", "games_201819.csv", package = "bleaguer", mustWork = TRUE)
  df <- readr::read_csv(file,
                        col_types = colTypes,
                        locale = readr::locale(encoding = "UTF-8"))
  result <- rbind(result, df)

  return(result)
}

#' @export
LoadGameSummary <- function() {
  colTypes <- list(
    # ScheduleKey, TeamId
    readr::col_integer(),
    readr::col_integer(),
    # PTS, Q1-4, OT1-4
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    # F2, F3, FT M and A
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    # OR, DR, TR
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    # AS, TO, ST
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    # BS, F
    readr::col_integer(),
    readr::col_integer(),
    # Advanced
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    readr::col_integer(),
    # Scoring run
    readr::col_character(),
    # Lead changes and Times tied
    readr::col_integer(),
    readr::col_integer()
  )

  file <- system.file("extdata", "games_summary_201617.csv", package = "bleaguer", mustWork = TRUE)
  df <- readr::read_csv(file,
                        col_types = colTypes,
                        locale = readr::locale(encoding = "UTF-8"))
  result <- df

  file <- system.file("extdata", "games_summary_201718.csv", package = "bleaguer", mustWork = TRUE)
  df <- readr::read_csv(file,
                        col_types = colTypes,
                        locale = readr::locale(encoding = "UTF-8"))
  result <- rbind(result, df)

  file <- system.file("extdata", "games_summary_201819.csv", package = "bleaguer", mustWork = TRUE)
  df <- readr::read_csv(file,
                        col_types = colTypes,
                        locale = readr::locale(encoding = "UTF-8"))
  result <- rbind(result, df)

  return(result)
}

# Objects that get loaded by default when this package gets loaded
b.teams <- LoadTeams()
b.events <- LoadEvents()
b.games <- LoadGames()
b.games.summary <- LoadGameSummary()
