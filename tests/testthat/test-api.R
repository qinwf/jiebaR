context("C_API tests")
library(devtools)
library(testthat)

library(jiebaR)
cc = worker()
invisible(cc["unzip"])

test_that("C_API",{
  install("./C_API")
  expect_true(!any(as.data.frame(test("./C_API"))[["error"]]) )
  # expect_error(not(check(as.package("./C_API"))))
})

test_that("CPP_API",{
  install("./CPP_API")
  expect_true(!any(as.data.frame(test("./CPP_API"))[["error"]]) )
  # expect_error(not(check(as.package("./CPP_API"))))
})
