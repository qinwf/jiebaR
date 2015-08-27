context("C API")

test_that("hmm c api",{
  cutter = jiebaRapi:::hmm_ptr(jiebaR:::HMMPATH)
  expect_equal(jiebaRapi:::hmm_cut("this is test",cutter),c("this", " ", "is", " ", "test"))
})
