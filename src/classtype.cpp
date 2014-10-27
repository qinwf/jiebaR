#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cstdio>
#include <sstream>
#include "MixSegment.hpp"
#include "MPSegment.hpp"
#include "HMMSegment.hpp"
#include "QuerySegment.hpp"
#include "PosTagger.hpp"
#include "KeywordExtractor.hpp"
#include <Rcpp.h>
using namespace Rcpp;
using namespace CppJieba;

class mpseg{
    public:    
    const char * const dict_path;
    const char * const user_path;
    MPSegment mpsegment;        
    mpseg(CharacterVector dict,CharacterVector user) : 
    dict_path(dict[0]),user_path(user[0]),mpsegment(dict_path,user_path){
    }
    ~mpseg(){};
    
    CharacterVector cut(CharacterVector x)  {
      const char * const test_lines = x[0];
      vector<string> words;
      mpsegment.cut(test_lines, words);
      return wrap(words);}
};


RCPP_MODULE(mod_mpseg){
  class_<mpseg>( "mpseg")
  .constructor<CharacterVector,CharacterVector>()
  .method( "cut", &mpseg::cut)
  ;
}

class mixseg{
    public:    
    const char * const dict_path;
    const char * const user_path;
    const char * const model_path;
    MixSegment mixsegment;        
    mixseg(CharacterVector dict,CharacterVector model,CharacterVector user) : 
    dict_path(dict[0]),model_path(model[0]),user_path(user[0]),mixsegment(dict_path,model_path,user_path){
    }
    ~mixseg(){};
    
    CharacterVector cut(CharacterVector x)  {
      const char * const test_lines = x[0];
      vector<string> words;
      mixsegment.cut(test_lines, words);
      return wrap(words);}
};

RCPP_MODULE(mod_mixseg){
  class_<mixseg>( "mixseg")
  .constructor<CharacterVector,CharacterVector,CharacterVector>()
  .method( "cut", &mixseg::cut)
  ;
}
