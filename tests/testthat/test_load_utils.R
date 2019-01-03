context("Testing load_util")

test_that("Test cases for the team data.frame", {
  expect_true(exists("b.teams"))
  expect_equal(
    nrow(subset(b.teams, Season == "2016-17" & League == "B1")),
    18)
  expect_equal(
    nrow(subset(b.teams, Season == "2016-17" & League == "B2")),
    18)
  expect_equal(
    nrow(subset(b.teams, Season == "2017-18" & League == "B1")),
    18)
  expect_equal(
    nrow(subset(b.teams, Season == "2017-18" & League == "B2")),
    18)
  expect_equal(
    nrow(subset(b.teams, Season == "2018-19" & League == "B1")),
    18)
  expect_equal(
    nrow(subset(b.teams, Season == "2018-19" & League == "B2")),
    18)
})

test_that("Test cases for the event data.frame", {
  expect_true(exists("b.events"))
  expect_equal(nrow(b.events), 12)
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
  expect_gt(
    nrow(subset(b.games, Season == "2018-19" & EventId == 2)), #B1 RS
    0
  )
  expect_gt(
    nrow(subset(b.games, Season == "2018-19" & EventId == 7)), #B2 RS
    0
  )
})

test_that("Test cases for the game summary data.frame exists", {
  expect_true(exists("b.games.summary"))

  num.row <- nrow(b.games.summary)
  num.uniqueId <- length(unique(b.games.summary$ScheduleKey))
  expect_equal(
    num.row,
    num.uniqueId * 2
  )
})
