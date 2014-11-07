#include <iostream>
#include <algorithm>
#include <fstream>
#include <cstdlib>
#include <cstdio>
#include <sstream>
#include "MixSegment.hpp"

#include <Rcpp.h>
using namespace Rcpp;
using namespace CppJieba;

// [[Rcpp::depends(RcppParallel)]]
#include <RcppParallel.h>
using namespace RcppParallel;


class mixseg
{
public:
  char * dict_path;
  char * model_path;
  char * user_path;
  MixSegment mixsegment;
  mixseg(CharacterVector dict, CharacterVector model, CharacterVector user) :
    dict_path(dict[0]), model_path(model[0]), user_path(user[0]), mixsegment(dict_path, model_path, user_path)
  {
  }
  mixseg(const mixseg& b) :  dict_path(b.dict_path), model_path(b.model_path), user_path(b.user_path), 
  mixsegment(dict_path, model_path, user_path){
    
  }
  ~mixseg() {};
  
  CharacterVector cut(CharacterVector x)
  {
    const char *const test_lines = x[0];
    vector<string> words;
    mixsegment.cut(test_lines, words);
    return wrap(words);
  }
  
  vector<string> cutstring(const char *const test_lines)
  {
    
    vector<string> words;
    mixsegment.cut(test_lines, words);
    return words;
  }
};

RCPP_MODULE(mod_mixseg)
{
  class_<mixseg>( "mixseg")
  .constructor<CharacterVector, CharacterVector, CharacterVector>()
  .method( "cut", &mixseg::cut)
  ;
}

class mixpara : public Worker
{
public:
  vector<string> inputstring;
  vector< vector<string> > results;
  mixseg mixobj;
  mixpara(CharacterVector dict, CharacterVector model,
          CharacterVector user,int n) :mixobj(dict,model,user)
    
  {
    results.resize(n) ;
    //     for(int i = 0;i<n;i++)
    //       mixobj.emplace_back(dict,model,user);
  }
  
  void operator()(std::size_t begin, std::size_t end) {
    for (std::size_t j = begin; j < end; j++){       
      results[j] = mixobj.cutstring(inputstring[j].c_str());
      
    }
  }
  
};

class applymix{
public:
  mixpara paraworker;
  applymix(CharacterVector dict, CharacterVector model,
           CharacterVector user,int n) : paraworker(dict, model, user,n ) {}
  
  CharacterVector cut(vector<string> inputfromR) {
    
    paraworker.inputstring = inputfromR;
    
    vector<string> output;
    
    parallelFor(0, inputfromR.size() , paraworker );
    
    for(unsigned int i=0;i<inputfromR.size();i++){
      copy(paraworker.results[i].begin(), paraworker.results[i].end(), back_inserter(output));
    }
    return wrap(output);
  }
};

RCPP_MODULE(mod_paramix)
{
  class_<applymix>( "applymix")
  .constructor<CharacterVector, CharacterVector, CharacterVector,int>()
  .method( "cut", &applymix::cut)
  ;
}




