context("C_API tests")
library(devtools)
library(testthat)

test_that("C_API",{

  expect_error(not(check(as.package("./C_API"))))
})

test_that("CPP_API",{

  expect_error(not(check(as.package("./CPP_API"))))
})
