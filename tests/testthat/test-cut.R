if(.Platform$OS.type=="windows"){
  test_that("mixcut", {
    expect_equal(mixcut("大家好，这是一个测试文本"), 
    c("大家","好",",","这是","一个","测试","文本")%>%iconv("UTF-8","GBK"))
})


  }
