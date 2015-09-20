context("C API")

test_that("hmm c api",{
  cutter = jiebaRapi:::hmm_ptr(jiebaR::HMMPATH,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::hmm_cut("this is test",cutter),c("this", " ", "is", " ", "test"))
})

test_that("mix c api",{
  cutter = jiebaRapi:::mix_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,jiebaR::USERPATH,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::mix_cut("this is test",cutter),c("this", " ", "is", " ", "test"))
})

test_that("mp c api",{
  cutter = jiebaRapi:::mp_ptr(jiebaR::DICTPATH,jiebaR::USERPATH,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::mp_cut("this is test",cutter),c("t", "h", "i", "s", " ", "i", "s", " ", "t", "e", "s", "t"))
})

test_that("query c api",{
  cutter = jiebaRapi:::query_ptr(jiebaR::DICTPATH,jiebaR::HMMPATH,20,jiebaR::STOPPATH)
  expect_equal(jiebaRapi:::query_cut("this is test",cutter),c("this", " ", "is", " ", "test"))
})

