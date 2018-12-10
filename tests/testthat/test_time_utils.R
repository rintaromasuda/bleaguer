context("Testing time_utils")

test_that("ConvertMinStrToDec on standard cases", {
  expect_equal(ConvertMinStrToDec("22:30"), 22.5)
  expect_equal(ConvertMinStrToDec("22:30:00"), 22.5)
  expect_equal(ConvertMinStrToDec("00:30"),0.5)
  expect_equal(ConvertMinStrToDec("00:30:00"),0.5)
})
