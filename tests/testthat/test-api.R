context("C_API tests")
library(devtools)
library(testthat)

library(jiebaR)
cc = worker()
invisible(cc["unzip"])

test_that("C_API",{
  # testthat is not supported on Solari r-patched and R 3.3.0 on 2016/4/16
  skip_on_cran()
  install("./C_API")
  expect_true(!any(as.data.frame(test("./C_API"))[["error"]]) )
  # expect_error(not(check(as.package("./C_API"))))
})

test_that("CPP_API",{
  # testthat is not supported on Solari r-patched and Windows R 3.3.0 on 2016/4/16
  skip_on_cran()
  install("./CPP_API")
  expect_true(!any(as.data.frame(test("./CPP_API"))[["error"]]) )
  # expect_error(not(check(as.package("./CPP_API"))))
})
