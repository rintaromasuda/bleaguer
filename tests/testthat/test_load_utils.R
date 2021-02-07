context("Testing load_util")

test_that("Test cases for the team data.frame", {
  expect_true(exists("b.teams"))
  expect_equal(
    length(unique(subset(b.teams, Season == "2016-17" & League == "B1")$TeamId)),
    18)
  expect_equal(
    length(unique(subset(b.teams, Season == "2016-17" & League == "B2")$TeamId)),
    18)
  expect_equal(
    length(unique(subset(b.teams, Season == "2017-18" & League == "B1")$TeamId)),
    18)
  expect_equal(
    length(unique(subset(b.teams, Season == "2017-18" & League == "B2")$TeamId)),
    18)
  expect_equal(
    length(unique(subset(b.teams, Season == "2018-19" & League == "B1")$TeamId)),
    18)
  expect_equal(
    length(unique(subset(b.teams, Season == "2018-19" & League == "B2")$TeamId)),
    18)
  expect_equal(
    length(unique(subset(b.teams, Season == "2019-20" & League == "B1")$TeamId)),
    18)
  expect_equal(
    length(unique(subset(b.teams, Season == "2019-20" & League == "B2")$TeamId)),
    18)
  expect_equal(
    length(unique(subset(b.teams, Season == "2020-21" & League == "B1")$TeamId)),
    20)
  expect_equal(
    length(unique(subset(b.teams, Season == "2020-21" & League == "B2")$TeamId)),
    16)
})

test_that("Test cases for the event data.frame", {
  expect_true(exists("b.events"))
  expect_equal(nrow(b.events), 13)
})

test_that("Test cases for the game data.frame", {
  # Object exists
  expect_true(exists("b.games"))

  # ScheduleKey is unique
  expect_equal(
    nrow(b.games),
    length(unique(b.games$ScheduleKey))
  )

  # One regular season is 540 games
  expect_equal(
    nrow(subset(b.games, Season == "2016-17" & EventId == 2)), #B1 RS
    540
  )
  expect_equal(
    nrow(subset(b.games, Season == "2016-17" & EventId == 7)), #B2 RS
    540
  )
  expect_equal(
    nrow(subset(b.games, Season == "2017-18" & EventId == 2)), #B1 RS
    540
  )
  expect_equal(
    nrow(subset(b.games, Season == "2017-18" & EventId == 7)), #B2 RS
    540
  )
  expect_equal(
    nrow(subset(b.games, Season == "2018-19" & EventId == 2)), #B1 RS
    540
  )
  expect_equal(
    nrow(subset(b.games, Season == "2018-19" & EventId == 7)), #B2 RS
    540
  )
  expect_equal(
    nrow(subset(b.games, Season == "2019-20" & EventId == 2)), #B1 RS
    367 #Number of games done in 2019-20 (ended in the middle due to the pandemic)
  )
  expect_equal(
    nrow(subset(b.games, Season == "2019-20" & EventId == 7)), #B2 RS
    423 #Number of games done in 2019-20 (ended in the middle due to the pandemic)
  )
  expect_gt(
    nrow(subset(b.games, Season == "2020-21" & EventId == 2)), #B1 RS
    0
  )
  expect_gt(
    nrow(subset(b.games, Season == "2020-21" & EventId == 7)), #B2 RS
    0
  )
})

test_that("Test cases for the game summary data.frame", {
  expect_true(exists("b.games.summary"))

  num.row <- nrow(b.games.summary)
  num.uniqueId <- length(unique(b.games.summary$ScheduleKey))
  expect_equal(
    num.row,
    num.uniqueId * 2
  )
})

test_that("Test cases for the game boxscore data.frame", {
  expect_true(exists("b.games.boxscore"))

  num.row <- nrow(b.games.boxscore)
  num.unique <- nrow(unique(b.games.boxscore[, c("ScheduleKey", "TeamId", "PlayerId")]))
  expect_equal(
    num.row,
    num.unique
  )
})

test_that("Test cases for making sure ScheduleKey matches across games, summary and boxscore", {
  expect_true(exists("b.games"))
  expect_true(exists("b.games.summary"))
  expect_true(exists("b.games.boxscore"))

  #num.uniqueId.games <- length(unique(b.games$ScheduleKey))
  #num.uniqueId.summary <- length(unique(b.games.summary$ScheduleKey))
  #num.uniqueId.boxscore <- length(unique(b.games.boxscore$ScheduleKey))

  #expect_equal(
  #  num.uniqueId.games,
  #  num.uniqueId.summary
  #)

  #expect_equal(
  #  num.uniqueId.games,
  #  num.uniqueId.boxscore
  #)
})
