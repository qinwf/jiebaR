context("CPP API")

test_that("hmm cpp api",{
  cutter = jiebaRapi:::hmm_ptr(jiebaR::HMMPATH,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::hmm_cut("this is test",cutter),c("this", " ", "is", " ", "test"))
})

test_that("mix cpp api",{
  cutter = jiebaRapi:::mix_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,jiebaR::USERPATH,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::mix_cut("this is test",cutter),c("this", " ", "is", " ", "test"))
})

test_that("mp cpp api",{
  cutter = jiebaRapi:::mp_ptr(jiebaR::DICTPATH,jiebaR::USERPATH,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::mp_cut("this is test",cutter),c("t", "h", "i", "s", " ", "i", "s", " ", "t", "e", "s", "t"))
})

test_that("query cpp api",{
  cutter = jiebaRapi:::query_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,20,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::query_cut("this is test",cutter),c("this", " ", "is", " ", "test"))
})

