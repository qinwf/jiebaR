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
                   structure(list(distance = "0", 
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
  expect_identical({freq(c("测试", "测试", "文本","大风","是的是的"))},structure(list(char = c("是的是的", "测试", "大风", "文本"), freq = c(1, 2, 1, 1)), .Names = c("char", "freq"), row.names = c(NA, -4L), class = "data.frame"))
  expect_identical({freq(cutter["今天是周二，是一个晴天。"])},structure(list(char = c("是", "周二", "晴天", "一个", "今天"), freq = c(2, 1, 1, 1, 1)), .Names = c("char", "freq"), row.names = c(NA, -5L), class = "data.frame"))
})

