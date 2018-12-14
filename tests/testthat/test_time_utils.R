context("Testing time_utils")

test_that("ConvertMinStrToDec on standard cases", {
  expect_equal(ConvertMinStrToDec("22:30"), 22.5)
  expect_equal(ConvertMinStrToDec("22:30:00"), 22.5)
  expect_equal(ConvertMinStrToDec("00:30"),0.5)
  expect_equal(ConvertMinStrToDec("00:30:00"),0.5)
})

test_that("GetFullDateString on standard cases", {
  expect_equal(GetFullDateString("9.30", "2016-17"), "2016.09.30")
  expect_equal(GetFullDateString("12.30", "2016-17"), "2016.12.30")
  expect_equal(GetFullDateString("1.30", "2016-17"), "2017.01.30")

  actuals <- GetFullDateString(c("9.30","12.30","1.30"), c("2016-17", "2016-17", "2016-17"))
  expect_equal(actuals[1], "2016.09.30")
  expect_equal(actuals[2], "2016.12.30")
  expect_equal(actuals[3], "2017.01.30")
})
