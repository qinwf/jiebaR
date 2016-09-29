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
  
  expect_identical(distance("hello world" , "hello world!" , simhasher),structure(list(distance = 0L, lhs = structure("hello", .Names = "11.7392"),rhs = structure("hello", .Names = "11.7392")), .Names = c("distance","lhs", "rhs")))
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

test_that("tobin", {
  expect_equal(tobin("200000000000000000"), "0000001011000110100010101111000010111011000101000000000000000000")
  expect_equal(tobin("2"),"0000000000000000000000000000000000000000000000000000000000000010")
})

test_that("tools",{
  invisible(show_dictpath())
})

test_that("get_idf",{
  res = get_idf(list(c("a","b","c"), c("1","a","b","2")))
  expect_true(nrow(res) == 2)
  expect_true(res[res[,1] == "b",]["count"] == 0)
  expect_true(round(res[res[,1] == "c",]["count"],digits = 2) == 0.69)
})

test_that("get_tuple",{
  res = get_tuple(c("sd","sd","sd","rd"),2)
  expect_true(nrow(res) == 2)
  expect_true(res[res[,1] == "sdsd",]["count"] == 2L)
  expect_true(res[res[,1] == "sdrd",]["count"] == 1L)
  
})

test_that("ham_dist", {
  expect_equal(simhash_dist("1","1"), 0)
  expect_equal(simhash_dist("1","2"), 2)
  res = simhash_dist_mat(c("1","12","123"),c("2","1"))
  expect_equal(res, structure(c(2L, 3L, 5L, 0L, 3L, 5L), .Dim = c(3L, 2L)))
})

test_that("print",{
  print(worker())
  print(worker("keywords"))
  print(worker("simhash"))
})
