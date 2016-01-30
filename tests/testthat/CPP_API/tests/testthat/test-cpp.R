context("CPP API")

#unzip
cutter = jiebaR::worker()

test_that("hmm cpp api",{
  expect_warning(jiebaRapi:::hmm_ptr(jiebaR::HMMPATH,NULL))
  expect_warning(jiebaRapi:::hmm_cut("this is test",cutter))
  expect_warning(jiebaRapi:::hmm_ptr(jiebaR::HMMPATH,jiebaR::STOPPATH))
  expect_warning(jiebaRapi:::hmm_cut("this is test",cutter))
})

test_that("mix cpp api",{
  suppressWarnings({
    cutter = jiebaRapi:::mix_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,jiebaR::USERPATH,NULL)
    expect_equal(jiebaRapi:::mix_cut("this is test",cutter),c("this", " ", "is", " ", "test"))
    cutter = jiebaRapi:::mix_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,jiebaR::USERPATH,jiebaR::STOPPATH)
    expect_equal(jiebaRapi:::mix_cut("this is test",cutter),c("test"))
    }
    )
})

test_that("mp cpp api",{
  expect_warning(jiebaRapi:::mp_ptr(jiebaR::DICTPATH,jiebaR::USERPATH,NULL))
  expect_warning(jiebaRapi:::mp_cut("this is test",cutter))
  expect_warning(jiebaRapi:::mp_ptr(jiebaR::DICTPATH,jiebaR::USERPATH,jiebaR::STOPPATH))
  expect_warning(jiebaRapi:::mp_cut("this is test",cutter))

})

test_that("query cpp api",{
  expect_warning(jiebaRapi:::query_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,20,NULL))
  expect_warning(jiebaRapi:::query_cut("this is test",cutter))
  expect_warning(jiebaRapi:::query_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,20,jiebaR::STOPPATH))
  expect_warning(jiebaRapi:::query_cut("this is test",cutter))
})

test_that("keys cpp api",{
  cutter = jiebaRapi:::key_ptr(4,jiebaR::DICTPATH,jiebaR::HMMPATH,jiebaR::IDFPATH,jiebaR::STOPPATH,jiebaR::USERPATH)

  expect_equal(jiebaRapi:::key_cut("this is test",cutter),c("test"))

  expect_equal(jiebaRapi:::key_keys("this is test",cutter),structure("this is test", .Names = "11.7392"))

  expect_equal(jiebaRapi:::key_tag("this is test",cutter),structure("test", .Names = "11.7392"))
  
})

test_that("simhahs cpp api",{
  cutter = jiebaRapi:::sim_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,
                               jiebaR::IDFPATH,jiebaR::STOPPATH,jiebaR::USERPATH)
  
  expect_equal(jiebaRapi:::sim_sim("this is test",3,cutter),
               structure(list(simhash = "13694348408744233390",
                              keyword = structure("test", .Names = "11.7392")),
                         .Names = c("simhash", "keyword")))
  
  expect_equal(jiebaRapi:::sim_distance("this is test","this is test",3,cutter),
               structure(list(distance = "0", lhs = 
                                structure("test", .Names = "11.7392"), 
               rhs = structure("test", .Names = "11.7392")), 
               .Names = c("distance", 
                          "lhs", "rhs")))
})

test_that("tag cpp api",{
  suppressWarnings( {
    cutter = jiebaRapi:::tag_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,jiebaR::USERPATH,NULL)
  expect_equal(jiebaRapi:::tag_tag("this is test",cutter),
               structure(c("this", " ", "is", " ", "test"), 
                         .Names = c("eng", "x", "eng", "x", "eng"))
               )
  cutter = jiebaRapi:::tag_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,jiebaR::USERPATH,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::tag_tag("this is test",cutter),structure("test", .Names = "eng"))
  
  })
})

test_that("jieba cpp api",{
  cutter = jiebaRapi:::jieba_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,jiebaR::USERPATH,NULL)
  expect_equal(jiebaRapi:::jieba_mix_cut("this is test",cutter),c("this", " ", "is", " ", "test"))
  cutter = jiebaRapi:::jieba_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,jiebaR::USERPATH,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::jieba_mix_cut("this is test",cutter),c("test"))
})