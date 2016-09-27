context("All tests")

test_that("segmentation", {
  cutter = worker("hmm")
  expect_identical({cutter <= "This is Test"}, c("This","is","Test"))
  cutter = worker("mix")
  expect_identical({cutter <= "这是一个测试"}, c("这是", "一个", "测试"))
  expect_identical({cutter <= "。、，；-！@#￥%……&*（）’"}, character(0))
  cutter = worker("tag")
  expect_identical({cutter <= "这是一个测试"},
                   structure(c("这是", "一个", "测试"), .Names = c("x", "m", "vn"
  )))
  cutter = worker("simhash")
  expect_identical({cutter <= "这是一个测试"},
                   structure(list(simhash = "1460457335435046831", 
                                  keyword = structure(c("测试", "这是", "一个"),
                                  .Names = c("7.14724", "4.29163", "2.81755"))),
                                  .Names = c("simhash", "keyword")))
  expect_identical({distance( "这是一个测试","这是一个测试",cutter)},
                   structure(list(distance = 0L, 
                                  lhs = structure(c("测试", "这是","一个"), .Names = c("7.14724", "4.29163", "2.81755")), 
                                  rhs = structure(c("测试", "这是", "一个"), .Names = c("7.14724", "4.29163", "2.81755"))),
                             .Names = c("distance", "lhs", "rhs")))
  cutter = worker("keywords")
  expect_identical({cutter <= "这是一个测试"},
                   structure(c("测试", "这是", "一个"), .Names = c("7.14724", "4.29163", 
                                                             "2.81755")))
})

cutter = worker()

test_that("segmentation", {

  result_segment = cutter["我是测试文本，用于测试过滤分词效果。"]
  filter_words = c("我","你","它","大家")
  expect_identical( {filter_segment(result_segment,filter_words)},
                    c("是", "测试", "文本", "用于", "测试", "过滤",
                      "分词", "效果")
  )
})

test_that("filter_words", {
  result_segment = list(cutter["我是测试文本，用于测试过滤分词效果。"],
                        cutter["测试文本，用于测试过滤分词效果。"])
  filter_words = c("我","你","它","大家","测","是")
  expect_identical( {filter_segment(result_segment,filter_words)},
                    list(c("测试", "文本", "用于", "测试", 
                           "过滤", "分词", "效果"), c("测试", "文本",
                            "用于", "测试", "过滤", "分词", "效果"))
  )
  res = freq(c("测试", "测试", "文本","大风","是的是的"))
  res = res[order(res[,1]),]
  expect_identical( res,
                   structure(list(char = c("测试", "大风", "是的是的", "文本"), freq = c(2, 1, 1, 1)), .Names = c("char", "freq"), row.names = c(4L, 2L, 1L, 3L), class = "data.frame"))
  
  res = freq(cutter["今天是周二，是一个晴天。"])
  res = res[order(res[,1]),]
  
  expect_equivalent( res,
                   structure(list(char = c("今天", "晴天", "是", "一个", "周二"), freq = c(1, 1, 2, 1, 1)), .Names = c("char", "freq"), row.names = c(5L, 2L, 4L, 1L, 3L), class = "data.frame"))
})

test_that("words_locate", {
  cc = worker()
  
  expect_identical(words_locate(cc["我是谁"]),list(c("我", "是", "谁"), c("0", "1", "2"), c("1", "2", "3")))
  
  expect_identical(words_locate(cc["这是一个测试文本"]),list(c("这是", "一个", "测试", "文本"), c("0", "2", "4", "6"), c("2", "4", "6", "8")))
})

test_that("new_user_word", {
  cc = worker()
  
  expect_identical(cc["我是谁"],c("我", "是", "谁"))
  expect_true(new_user_word(cc,"我是谁","n"))
  expect_identical(cc["我是谁"],c("我是谁"))
  expect_identical(segment("我是谁",cc,"tag"),structure("我是谁", .Names = "n"))

})

test_that("vector_", {
  cc = worker()
  sims = worker("simhash")
  res = cc["这是测试文本"]
  
  expect_identical(vector_simhash(cc["这是测试文本"],sims), structure(list(simhash = "10122323870055346090", keyword = structure(c("文本", "测试", "这是"), .Names = c("8.94485", "7.14724", "4.29163"))), .Names = c("simhash", "keyword")))
  
  sims$topn = 2
  
  expect_identical(vector_simhash(cc["这是测试文本"],sims), structure(list(simhash = "10014870797707624170", keyword = structure(c("文本", "测试"), .Names = c("8.94485", "7.14724"))), .Names = c("simhash", "keyword")))
  
  expect_identical(vector_distance(cc["测试这个恶"], cc["好玩不好玩"],sims),structure(list(distance = 23L, lhs = structure("测试", .Names = "7.14724"), rhs = structure(c("不好玩", "好玩"), .Names = c("11.8212", "9.01033"))), .Names = c("distance", "lhs", "rhs")))
  
  keyz = worker("keywords")
  
  expect_identical(vector_keywords(cc["测试这个恶好玩不好玩"],keyz),structure(c("不好玩", "好玩", "测试"), .Names = c("11.8212", "9.01033", "7.14724")))
})
