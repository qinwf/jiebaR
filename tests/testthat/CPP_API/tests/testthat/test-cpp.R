context("CPP API")

#unzip
cc = worker()

test_that("hmm cpp api",{
  cutter = jiebaRapi:::hmm_ptr(jiebaR::HMMPATH,NULL)
  expect_equal(jiebaRapi:::hmm_cut("this is test",cutter),c("this", " ", "is", " ", "test"))
  cutter = jiebaRapi:::hmm_ptr(jiebaR::HMMPATH,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::hmm_cut("this is test",cutter),c("test"))
})

test_that("mix cpp api",{
  cutter = jiebaRapi:::mix_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,jiebaR::USERPATH,NULL)
  expect_equal(jiebaRapi:::mix_cut("this is test",cutter),c("this", " ", "is", " ", "test"))
  cutter = jiebaRapi:::mix_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,jiebaR::USERPATH,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::mix_cut("this is test",cutter),c("test"))
})

test_that("mp cpp api",{
  cutter = jiebaRapi:::mp_ptr(jiebaR::DICTPATH,jiebaR::USERPATH,NULL)
  expect_equal(jiebaRapi:::mp_cut("this is test",cutter),c("t", "h", "i", "s", " ", "i", "s", " ", "t", "e", "s", "t"))
  cutter = jiebaRapi:::mp_ptr(jiebaR::DICTPATH,jiebaR::USERPATH,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::mp_cut("this is test",cutter),c("t", "h", "s", "s", "t", "e", "s", "t")
)
})

test_that("query cpp api",{
  cutter = jiebaRapi:::query_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,20,NULL)
  expect_equal(jiebaRapi:::query_cut("this is test",cutter),c("this", " ", "is", " ", "test"))
  cutter = jiebaRapi:::query_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,20,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::query_cut("this is test",cutter),c("test"))
})

test_that("keys cpp api",{
  cutter = jiebaRapi:::key_ptr(4,jiebaR::DICTPATH,jiebaR::HMMPATH,jiebaR::IDFPATH,jiebaR::STOPPATH)

  expect_equal(jiebaRapi:::key_cut("this is test",cutter),c("test"))

  expect_equal(jiebaRapi:::key_keys("this is test",cutter),structure("this is test", .Names = "11.7392"))

  expect_equal(jiebaRapi:::key_tag("this is test",cutter),structure("test", .Names = "11.7392"))
  
})

test_that("simhahs cpp api",{
  cutter = jiebaRapi:::sim_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,
                               jiebaR::IDFPATH,jiebaR::STOPPATH)
  
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
  cutter = jiebaRapi:::tag_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,jiebaR::USERPATH,NULL)
  expect_equal(jiebaRapi:::tag_tag("this is test",cutter),
               structure(c("this", " ", "is", " ", "test"), 
                         .Names = c("eng", "x", "eng", "x", "eng"))
               )
  cutter = jiebaRapi:::tag_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,jiebaR::USERPATH,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::tag_tag("this is test",cutter),structure("test", .Names = "eng"))
})