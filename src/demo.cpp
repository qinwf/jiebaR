#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cstdio>
#include "MixSegment.hpp"
#include <Rcpp.h>
using namespace Rcpp;

using namespace CppJieba;

const char * const dict_path =  "inst/dict/jieba.dict.utf8";
const char * const model_path = "inst/dict/hmm_model.utf8";

const char * const test_lines = "我来到南京市长江大桥";
MixSegment segment(dict_path, model_path);

//' @export
// [[Rcpp::export]]
CharacterVector cutw( ) {

   vector<string> words;
   segment.cut(test_lines, words);
   return wrap(words);
}
