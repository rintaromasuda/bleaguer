MergeSummary <- function(df) {
  # Merge b.teams twice both for the main team and the opponent team
  df <- merge(df, b.teams, by.x = c("TeamId", "Season"), by.y = c("TeamId", "Season"))
  df.teams.opp <- b.teams
  colnames(df.teams.opp) <- paste("Opp.", colnames(b.teams), sep = "")
  df <- merge(df, df.teams.opp, by.x = c("Opp.TeamId", "Season"), by.y = c("Opp.TeamId", "Opp.Season"))

  # Merge b.games.summary twice both for the main team and the opponent team
  df <- merge(df, b.games.summary, by.x = c("TeamId", "ScheduleKey"), by.y = c("TeamId", "ScheduleKey"))
  df.summary.opp <- b.games.summary
  colnames(df.summary.opp) <- paste("Opp.", colnames(b.games.summary), sep = "")
  df <- merge(df, df.summary.opp, by.x = c("Opp.TeamId", "ScheduleKey"), by.y = c("Opp.TeamId", "Opp.ScheduleKey"))

  return(df)
}

#' @export
GetGameSummary <- function() {
  df <- merge(b.games, b.events, by = "EventId")
  df$Event <- df$ShortName

  # This data frame treats the HOME team as the main team
  df.byHome <- df %>%
    dplyr::mutate(TeamId = HomeTeamId,
                  Opp.TeamId = AwayTeamId) %>%
    dplyr::select("ScheduleKey",
                  "Season",
                  "Category",
                  "Event",
                  "Date",
                  "Arena",
                  "Attendance",
                  "TeamId",
                  "Opp.TeamId")

  # This data frame treats the AWAY team as the main team
  df.byAway <- df %>%
    dplyr::mutate(TeamId = AwayTeamId,
                  Opp.TeamId = HomeTeamId) %>%
    dplyr::select("ScheduleKey",
                  "Season",
                  "Category",
                  "Event",
                  "Date",
                  "Arena",
                  "Attendance",
                  "TeamId",
                  "Opp.TeamId")

  df.byHome.merged <- MergeSummary(df.byHome)
  df.byHome.merged$HomeAway <- "Home"
  df.byAway.merged <- MergeSummary(df.byAway)
  df.byAway.merged$HomeAway <- "Away"
  df.result <- rbind(df.byHome.merged, df.byAway.merged)

  # Rename, select and sort the columns
  df.result$TeamName <- df.result$NameShort
  df.result$TeamDivision <- df.result$Division
  df.result$Opp.TeamName <- df.result$Opp.NameShort
  df.result$Opp.TeamDivision <- df.result$Opp.Division

  df.result <- df.result[, c("ScheduleKey",
                             "Season",
                             "League",
                             "Category",
                             "Event",
                             "Date",
                             "Arena",
                             "Attendance",
                             "TeamId",
                             "TeamName",
                             "TeamDivision",
                             "HomeAway",
                             "PTS",
                             "Q1",
                             "Q2",
                             "Q3",
                             "Q4",
                             "OT1",
                             "OT2",
                             "OT3",
                             "OT4",
                             "F2GM",
                             "F2GA",
                             "F3GM",
                             "F3GA",
                             "FTM",
                             "FTA",
                             "OR",
                             "DR",
                             "TR",
                             "AS",
                             "TO",
                             "ST",
                             "BS",
                             "F",
                             "PtsBiggestLead",
                             "PtsInPaint",
                             "PtsFastBreak",
                             "PtsSecondChance",
                             "PtsFromTurnover",
                             "BiggestScoringRun",
                             "Opp.TeamId",
                             "Opp.TeamName",
                             "Opp.TeamDivision",
                             "Opp.PTS",
                             "Opp.Q1",
                             "Opp.Q2",
                             "Opp.Q3",
                             "Opp.Q4",
                             "Opp.OT1",
                             "Opp.OT2",
                             "Opp.OT3",
                             "Opp.OT4",
                             "Opp.F2GM",
                             "Opp.F2GA",
                             "Opp.F3GM",
                             "Opp.F3GA",
                             "Opp.FTM",
                             "Opp.FTA",
                             "Opp.OR",
                             "Opp.DR",
                             "Opp.TR",
                             "Opp.AS",
                             "Opp.TO",
                             "Opp.ST",
                             "Opp.BS",
                             "Opp.F",
                             "Opp.PtsBiggestLead",
                             "Opp.PtsInPaint",
                             "Opp.PtsFastBreak",
                             "Opp.PtsSecondChance",
                             "Opp.PtsFromTurnover",
                             "Opp.BiggestScoringRun",
                             "LeadChanges",
                             "TimesTied"
                             )]

  return(df.result)
}

#' @export
SearchPlayer <- function(name) {
  df <- b.games.boxscore[, c("PlayerId", "Player", "TeamId")]
  df <- df[grepl(name, df$Player),]
  df <- unique(df)
  df <- merge(df, b.teams, by.x = "TeamId", by.y = "TeamId")
  df <- unique(df[,c("PlayerId", "Player", "NameLong")])
  return(df)
}
