#include <Rcpp.h>
using namespace Rcpp;
//' @export
// [[Rcpp::export]]
std::vector< std::string > cpp_str_sort( std::vector< std::string > strings ) {
  
  int len = strings.size();
 
  for( int i=0; i < len; i++ ) {
    std::sort( strings[i].begin(), strings[i].end() );
  }
  
  return strings;
}


//
//#include <Rcpp.h>
//using namespace Rcpp;
//
//#include <iostream>
//#include <fstream>
//#include <cstdlib>
//#include <cstdio>
//#include "MixSegment.hpp"
////#include "MPSegment.hpp"
////#include "HMMSegment.hpp"
////#include "FullSegment.hpp"
////#include "QuerySegment.hpp"
//
//using namespace CppJieba;
//
//const char * const dict_path =  "../inst/dict/jieba.dict.utf8";
//const char * const model_path = "../inst/hmm_model.utf8";
//
//const char * const test_lines = "我来到南京市长江大桥";
//
//
////' @export
//// [[Rcpp::export]]
//vector<string> signC(vector<string> strings) {
//  MixSegment segment(dict_path, model_path);
//  vector<string> words;
//  segment.cut(strings, words);
//  return words;
//}
