context("Testing load_util")

test_that("Test cases for the team master data frame", {
  expect_equal(length(unique(teams$TeamId)), 18)
})
