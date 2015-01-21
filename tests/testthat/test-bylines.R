context("Bylines tests")

skip_on_cran({
  cutter = worker(bylines = TRUE )
  test_that("bylines words input", {
    expect_identical({cutter[c("这是非常的好","大家好才是真的好")]},
                     list(c("这是", "非常", "的", "好"), 
                          c("大家", "好", "才", "是","真的", "好"))
                     )
    })
  cutter$bylines = FALSE
  test_that("bylines words input", {
    expect_identical({cutter[c("这是非常的好","大家好才是真的好")]},
                      c("这是", "非常", "的", "好", "大家", "好", "才"
                        , "是", "真的", "好")
                     )
  })
  cutter$bylines = TRUE
  cutter$output = "test.out"
  test_that("bylines words input", {
    expect_identical({cutter["bylines.utf8"]; out.r = file("test.out", open = "r");
                      res = readLines(out.r,encoding = "UTF-8");
                      close(out.r);
                      enc2utf8(res);
                      },
                     enc2utf8(c("这是 一个 分行 测试 文本", "用于 测试 分行 的 输出 结果"))
    )
  })
  file.remove("test.out")
  cutter = worker("tag",bylines = TRUE)
  cutter$write = FALSE
  test_that("bylines tag words input", {
    expect_identical(  cutter["bylines.utf8"],
                       list(structure(c("这是", "一个", "分行", "测试", "文本"), .Names = c("x", "m", "v", "vn", "n")), 
                            structure(c("用于", "测试", "分行", "的", "输出", "结果"), .Names = c("v", "vn", "v", "uj", "v", "n"))
                            )
    )
  })
})

