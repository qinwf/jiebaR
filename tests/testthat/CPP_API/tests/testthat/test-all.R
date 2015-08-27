context("CPP API")

test_that("hmm cpp api",{
  cutter = jiebaRapi:::hmm_ptr(jiebaR:::HMMPATH)
  expect_equal(jiebaRapi:::hmm_cut("this is test",cutter),c("this", " ", "is", " ", "test"))
})
