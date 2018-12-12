context("Testing load_util")

test_that("Test cases for the team data.frame", {
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
  expect_equal(nrow(b.events), 20)
})
