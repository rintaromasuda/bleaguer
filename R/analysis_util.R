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

  # Assing Game.Index (or Rank) to each game (per Season, TeamId, Category)
  df.result <- df.result %>%
    dplyr::group_by(Season, TeamId, Category) %>%
    dplyr::arrange(Date) %>%
    dplyr::mutate(Game.Index = dplyr::row_number())

  # The column telling you the result of the game
  df.result$WinLose <- factor(ifelse(df.result$PTS < df.result$Opp.PTS, "Lose", "Win"),
                              levels = c("Lose", "Win"))

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

GetTeamResultSummary <- function(df.game.summary, teamIds) {
  df.result <- df.game.summary %>%
    dplyr::filter(TeamId %in% teamIds & Opp.TeamId %in% teamIds) %>%
    dplyr::group_by(TeamName, TeamId, TeamDivision) %>%
    dplyr::summarise(Game = dplyr::n(),
                     Win = sum(WinLose == "Win"),
                     Lose = sum(WinLose == "Lose"),
                     WinRate = sum(WinLose == "Win") / dplyr::n(),
                     PtsDiff = sum(PTS) - sum(Opp.PTS),
                     PPG = sum(PTS) / dplyr::n()) %>%
    as.data.frame()

  return(df.result)
}

#' @export
GetStanding <- function(season, league, fromGame = 1, atEndOfGame = 60, needRank = FALSE) {
  df.game.summary <- subset(GetGameSummary(),
                            Season == season &
                              League == league &
                              Game.Index >= fromGame &
                              Game.Index <= atEndOfGame &
                              Category == "Regular")
  allTeamIds <- subset(b.teams, Season == season & League == league)$TeamId
  df.result <- GetTeamResultSummary(df.game.summary, allTeamIds)

  if (needRank) {
    #####
    # First, we rank all teams only by win rate
    #####
    df.rank <- df.result %>%
      dplyr::mutate(Rank = dplyr::min_rank(dplyr::desc(WinRate))) %>%
      dplyr::select(c("TeamId", "Rank")) %>%
      as.data.frame()

    #####
    # Second, if we have more than one teams having the same rank, we will adjust them by
    # comparing WinRate, PtsDiff, and PPG only within their matches.
    #####
    dupRanks <- df.rank$Rank[duplicated(df.rank$Rank)]
    dupRanks <- unique(dupRanks)
    for(rank in dupRanks) {
      dupTeamIds <- subset(df.rank, Rank == rank)$TeamId
      df.dupTeamResult <- GetTeamResultSummary(df.game.summary, dupTeamIds)
      if(nrow(df.dupTeamResult) > 0) {
        df.adjustedRank <- df.dupTeamResult %>%
          dplyr::mutate(Rank = dplyr::min_rank(interaction(dplyr::desc(WinRate),
                                                           dplyr::desc(PtsDiff),
                                                           dplyr::desc(PPG),
                                                           lex.order = TRUE))) %>%
          dplyr::mutate(Rank = Rank + rank - 1) %>%
          dplyr::select(c("TeamId", "Rank")) %>%
          as.data.frame()

        # If the teams didn't have a match yet, we don't adjust the rank for them
        if (nrow(df.adjustedRank) == length(dupTeamIds)) {
          df.rank <- rbind(
            subset(df.rank, Rank != rank),
            df.adjustedRank
          )
        }
      }
    }

    #####
    # Third, we'll do further rank by PtsDiff and PPG just in case we still have duplicates.
    # If we don't have duplicates, then the result should remain the same.
    #####
    df.result <- merge(df.result, df.rank, by = c("TeamId"))
    df.result <- df.result %>%
      dplyr::mutate(FinalRank = dplyr::min_rank(interaction(Rank,
                                                            dplyr::desc(PtsDiff),
                                                            dplyr::desc(PPG),
                                                            lex.order = TRUE))) %>%
      as.data.frame()

    df.result$Rank <- df.result$FinalRank
    df.result$FinalRank <- NULL

    # Adding per Division rank too
    df.result <- df.result %>%
      dplyr::group_by(TeamDivision) %>%
      dplyr::mutate(DivisionRank = dplyr::min_rank(Rank)) %>%
      as.data.frame()

    # Adding rank within "wild card" teams
    wildcardThreshold <- ifelse(league == "B1", 2, 1)
    df.wildcard <- df.result %>%
      dplyr::filter(DivisionRank > wildcardThreshold) %>%
      dplyr::mutate(WildcardRank = dplyr::min_rank(Rank)) %>%
      as.data.frame()

    df.result$WildcardRank <- NA
    df.result <- rbind(
      subset(df.result, DivisionRank <= wildcardThreshold),
      df.wildcard
    )
  }

  return(df.result)
}
