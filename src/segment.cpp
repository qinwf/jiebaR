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

// [[Rcpp::export]]
CharacterVector mix(CharacterVector x,CharacterVector dict,CharacterVector model,CharacterVector user)  {
  const char * const dict_path =  dict[0];
  const char * const model_path = model[0];
  const char * const user_path = user[0];
  MixSegment mixseg(dict_path, model_path,user_path);
  const char * const test_lines = x[0];
  vector<string> words;
  mixseg.cut(test_lines, words);
  return wrap(words);
}


// [[Rcpp::export]]
CharacterVector hmm(CharacterVector x,CharacterVector model)  {
  const char * const test_lines = x[0];
  const char * const model_path = model[0];
  HMMSegment hmmseg(model_path);
  vector<string> words;
  hmmseg.cut(test_lines, words);
  return wrap(words);
}


// [[Rcpp::export]]
CharacterVector mp(CharacterVector x,CharacterVector dict,CharacterVector user)  {
  const char * const dict_path =  dict[0];
  const char * const user_path = user[0];
  const char * const test_lines = x[0];
  MPSegment mpseg(dict_path,user_path);
  vector<string> words;
  mpseg.cut(test_lines, words);
  return wrap(words);
}


// [[Rcpp::export]]
CharacterVector taggerc(CharacterVector x,CharacterVector dict,CharacterVector model,CharacterVector user)  {
  const char * const test_lines = x[0];
  const char * const dict_path =  dict[0];
  const char * const model_path = model[0];
  const char * const user_path = user[0];
  PosTagger  taggersep(dict_path,model_path,user_path);
  multimap<string,string> m;
  vector<pair<string, string> > res;
  taggersep.tag(test_lines, res);
  vector<pair<string, string> >::iterator it;
  for(it=res.begin();it!=res.end();it++){
    m.insert(pair<string, string>((*it).second,(*it).first));}
    
    return wrap(m);
}


// [[Rcpp::export]]
CharacterVector keywordsc(CharacterVector x,CharacterVector dict,CharacterVector model,unsigned int n)  {
  const char * const dict_path =  dict[0];
  const char * const model_path = model[0];
  KeywordExtractor extractor(dict_path, model_path, "inst/dict/idf.utf8", "inst/dict/stop_words.utf8");
  size_t topN = n;
  const char * const test_lines = x[0];
  vector<string> words;
  extractor.extract(test_lines, words, topN);
  return wrap(words);
}

string itos(double i)  // convert int to string
	{
		stringstream s;
		s << i;
		return s.str();
	}


// [[Rcpp::export]]
CharacterVector keywordsweightc(CharacterVector x,CharacterVector dict,CharacterVector model,unsigned int n)  {
  const char * const dict_path =  dict[0];
  const char * const model_path = model[0];
  KeywordExtractor extractor(dict_path, model_path, "inst/dict/idf.utf8", "inst/dict/stop_words.utf8");
  size_t topN = n;
  const char * const test_lines = x[0];
  vector<pair<string, double> > res;
  multimap<string,string> m;
  extractor.extract(test_lines, res, topN);
  vector<pair<string, double> >::iterator it;
  for(it=res.begin();it!=res.end();it++){
    m.insert(pair<string, string>(itos((*it).second),(*it).first));}
    
    return wrap(m);
}



// [[Rcpp::export]]
CharacterVector query(CharacterVector x,CharacterVector dict,CharacterVector model,int n)  {
  const char * const dict_path =  dict[0];
  const char * const model_path = model[0];
  const char * const test_lines = x[0];
  QuerySegment queryseg(dict_path,model_path, n);
  vector<string> words;
  queryseg.cut(test_lines, words);
  return wrap(words);
}

