context("Operator tests")

cutter = worker("hmm",hmm =HMMPATH )
test_that("segmentation", {
  expect_identical({cutter <= "This is Test"}, c("This","is","Test"))
  expect_identical({cutter <= "AK47"}, c("AK47"))
})
