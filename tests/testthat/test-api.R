context("C_API tests")
library(devtools)
library(testthat)

test_that("C_API",{
  install_local("./C_API")
  expect_true(!any(as.data.frame(test("./C_API"))[["error"]]) )
  # expect_error(not(check(as.package("./C_API"))))
})

test_that("CPP_API",{
  install_local("./CPP_API")
  expect_true(!any(as.data.frame(test("./CPP_API"))[["error"]]) )
  # expect_error(not(check(as.package("./CPP_API"))))
})
