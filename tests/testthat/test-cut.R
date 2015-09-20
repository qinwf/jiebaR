context("Operator tests")

cutter = worker("hmm",hmm =HMMPATH )
cutter$symbol = TRUE
test_that("segmentation", {
  expect_identical({cutter <= "This is Test"}, c("This"," ","is"," ","Test"))
  expect_identical({cutter <= "AK47"}, c("AK47"))
  expect_identical({cutter <= "no Chinese for CRAN 2015-07-25"},c("no"," ", "Chinese", " ","for", " ","CRAN"," ", "2015-07-25"))
  cutter$symbol =F
  expect_identical({cutter <= "2015-07-25"},c("2015-07-25"))
  expect_identical({cutter <= "10.2"},c("10.2"))
  expect_identical({cutter <= "10.2,"},c("10.2"))
  cutter$symbol=T
  expect_identical({cutter <= "10.2,"},c("10.2",","))
})

cutter$symbol = FALSE
test_that("segmentation", {
  expect_identical({cutter <= "This is Test"}, c("This","is","Test"))
  expect_identical({cutter <= "AK47"}, c("AK47"))
  expect_identical({cutter <= "no Chinese for CRAN 2015-07-25"},c("no", "Chinese", "for", "CRAN","2015-07-25"))
})

test_that("simhash",{
  words = "hello world"
  simhasher = worker("simhash",topn=1)
  
  expect_identical(simhasher[words],structure(list(simhash = "3804341492420753273", keyword = structure("hello", .Names = "11.7392")), .Names = c("simhash","keyword")))
  
  expect_identical(distance("hello world" , "hello world!" , simhasher),structure(list(distance = "0", lhs = structure("hello", .Names = "11.7392"),rhs = structure("hello", .Names = "11.7392")), .Names = c("distance","lhs", "rhs")))
})

test_that("tagger",{
  words = "hello world"
  
  tagger = worker("tag")
  expect_identical(tagger[words],structure(c("hello", "world"), .Names = c("eng", "eng")))
  
})

test_that("keys",{
  keys = worker("keywords", topn = 1)
  expect_identical( keys <= "words of fun",structure("fun", .Names = "11.7392"))
  
})

