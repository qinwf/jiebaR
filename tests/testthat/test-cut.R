context("Operator tests")

cutter = worker("hmm",hmm =HMMPATH )
cutter$symbol = TRUE
test_that("segmentation", {
  expect_identical({cutter <= "This is Test"}, c("This"," ","is"," ","Test"))
  expect_identical({cutter <= "AK47"}, c("AK47"))
  expect_identical({cutter <= "no Chinese for CRAN 2015-07-25"},c("no"," ", "Chinese", " ","for", " ","CRAN"," ", "2015-07-25"))
})

cutter$symbol = FALSE
test_that("segmentation", {
  expect_identical({cutter <= "This is Test"}, c("This","is","Test"))
  expect_identical({cutter <= "AK47"}, c("AK47"))
  expect_identical({cutter <= "no Chinese for CRAN 2015-07-25"},c("no", "Chinese", "for", "CRAN","2015","07","25"))
})