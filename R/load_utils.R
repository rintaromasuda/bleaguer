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
  col_names <- c("EventId", "Leagues", "Category", "ShortName", "FriendlyName")
  events <- c(
    c(2,  "B1",    "Regular", "B1RS",   "B1レギュラーシーズン"),
    c(3,  "B1",    "Post",    "B1CS",   "B1チャンピオンシップ"),
    c(4,  "B1",    "Post",    "B1ZPF",  "B1残留プレーオフ"),
    c(5,  "B1,B2", "AllStar", "AS", "オールスターゲーム"),
    c(7,  "B2",    "Regular", "B2RS",   "B2レギュラーシーズン"),
    c(8,  "B2",    "Post",    "B2PF",   "B2プレーオフ"),
    c(9,  "B2",    "Post",    "B2ZPF",  "B2残留プレーオフ"),
    c(11, "B1,B2", "Post",    "B1B2SW", "B1/B2入れ替え戦"),
    c(17, "B2,B3", "Post",    "B2B3SW", "B2/B3入れ替え戦"),
    c(20, "B1,B2", "Pre",     "EC", "アーリーカップ")
    )
  m <- matrix(events, nrow = length(events) / length(col_names),
              ncol = length(col_names),
              byrow = TRUE)
  df <- as.data.frame(m, stringsAsFactors = TRUE)
  colnames(df) <- col_names
  df$EventId <- as.integer(as.character(df$EventId))
  return(df)
}

#' @export
GetEvents <- function(league, needCommonEvents = TRUE) {
  if (needCommonEvents) {
    return(subset(b.events, grepl(league, Leagues)))
  } else {
    return(subset(b.events, Leagues == league))
  }
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

  return(result)
}

# Objects that get loaded by default when this package gets loaded
b.teams <- LoadTeams()
b.events <- LoadEvents()
b.games <- LoadGames()
