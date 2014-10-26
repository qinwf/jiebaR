#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cstdio>
#include <sstream>
#include "MixSegment.hpp"
#include "MPSegment.hpp"
#include "HMMSegment.hpp"
#include "FullSegment.hpp"
#include "QuerySegment.hpp"
#include "PosTagger.hpp"
#include "KeywordExtractor.hpp"
#include <Rcpp.h>
using namespace Rcpp;

using namespace CppJieba;

const char * const dict_path =  "inst/dict/jieba.dict.utf8";
const char * const model_path = "inst/dict/hmm_model.utf8";
MixSegment mixseg(dict_path, model_path);
HMMSegment hmmseg(model_path);
MPSegment  mpseg(dict_path);
FullSegment fullseg(dict_path);
PosTagger  taggersep(dict_path,model_path);
KeywordExtractor extractor(dict_path, model_path, "inst/dict/idf.utf8", "inst/dict/stop_words.utf8");

// [[Rcpp::export]]
CharacterVector mixcutc(CharacterVector x)  {
  
  const char * const test_lines = x[0];
  vector<string> words;
  mixseg.cut(test_lines, words);
  return wrap(words);
}


// [[Rcpp::export]]
CharacterVector hmmcutc(CharacterVector x)  {
  
  const char * const test_lines = x[0];
  vector<string> words;
  hmmseg.cut(test_lines, words);
  return wrap(words);
}


// [[Rcpp::export]]
CharacterVector mpcutc(CharacterVector x)  {
  
  const char * const test_lines = x[0];
  vector<string> words;
  mpseg.cut(test_lines, words);
  return wrap(words);
}


// [[Rcpp::export]]
CharacterVector taggerc(CharacterVector x)  {
  multimap<string,string> m;
  const char * const test_lines = x[0];
  vector<pair<string, string> > res;
  taggersep.tag(test_lines, res);
  vector<pair<string, string> >::iterator it;
  for(it=res.begin();it!=res.end();it++){
    m.insert(pair<string, string>((*it).second,(*it).first));}
    
    return wrap(m);
}


// [[Rcpp::export]]
CharacterVector keywordsc(CharacterVector x,unsigned int n)  {
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
CharacterVector keywordsweightc(CharacterVector x,unsigned int n)  {
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
CharacterVector fullcutc(CharacterVector x)  {
  
  const char * const test_lines = x[0];
  vector<string> words;
  fullseg.cut(test_lines, words);
  return wrap(words);
}