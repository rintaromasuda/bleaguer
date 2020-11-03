context("Testing analysis_utils")

test_that("Test cases for data frames for analytics", {
  df <- GetGameSummary()

  df1617 <- subset(df, Season == "2016-17")
  df1718 <- subset(df, Season == "2017-18")
  df1819 <- subset(df, Season == "2018-19")
  df1920 <- subset(df, Season == "2019-20")

  # Expected number of records in regular season
  # 540 games in each league and each game has 2 record.
  expected <- 540 * 2

  expect_equal(
    nrow(subset(df1617, Category == "Regular" & League == "B1")),
    expected
  )

  expect_equal(
    nrow(subset(df1617, Category == "Regular" & League == "B2")),
    expected
  )

  expect_equal(
    nrow(subset(df1718, Category == "Regular" & League == "B1")),
    expected
  )

  expect_equal(
    nrow(subset(df1718, Category == "Regular" & League == "B2")),
    expected
  )

  expect_equal(
    nrow(subset(df1819, Category == "Regular" & League == "B1")),
    expected
  )

  expect_equal(
    nrow(subset(df1819, Category == "Regular" & League == "B2")),
    expected
  )

  expect_equal(
    nrow(subset(df1920, Category == "Regular" & League == "B1")),
    367 * 2 #Number of games done in 2019-20 (ended in the middle due to the pandemic)
  )

  expect_equal(
    nrow(subset(df1920, Category == "Regular" & League == "B2")),
    423 * 2 #Number of games done in 2019-20 (ended in the middle due to the pandemic)
  )
})

test_that("Test cases for data frames for standings", {
  for(season in c("2016-17", "2017-18", "2018-19")) {
    for(league in c("B1", "B2")) {
      df <- GetStanding(season, league, atEndOfGame = 60, needRank = TRUE)

      expect_equal(
        nrow(df),
        18
      )

      expect_equal(
        length(unique(df$Rank)),
        18
      )
    }
  }
})

test_that("Test cases for the data frame having # of games", {
  for(season in c("2016-17", "2017-18", "2018-19")) {
    df <- GetNumOfGames(season)
    for(row in 1:nrow(df)) {
      expect_equal(
        df[row,]$NumOfGames,
        60
      )
    }
  }
})

test_that("Test cases for the function returning a player's boxscore", {
  df <- GetBoxscore(8468, "2018-19") # Shigehiro Taguchi, Chiba Jets in 2018-19
  expect_gt(
    nrow(df),
    1
  )
})
