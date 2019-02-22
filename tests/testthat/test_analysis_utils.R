context("Testing analysis_utils")

test_that("Test cases for data frames for analytics", {
  df <- GetGameSummary()

  df1617 <- subset(df, Season == "2016-17")
  df1718 <- subset(df, Season == "2017-18")
  df1819 <- subset(df, Season == "2018-19")

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

  expect_gt(
    nrow(subset(df1819, Category == "Regular" & League == "B1")),
    100 # Temp value
  )

  expect_gt(
    nrow(subset(df1819, Category == "Regular" & League == "B2")),
    100 # Temp value
  )
})

test_that("Test cases for data frames for standings", {
  for(season in c("2016-17", "2017-18", "2018-19")) {
    for(league in c("B1", "B2")) {
      df <- GetStanding(season, league, 60, TRUE)

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
