#ifndef _SEGTYPE_HPP_
#define _SEGTYPE_HPP_

#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cstdio>
#include <sstream>
#include "lib/MixSegment.hpp"
#include "lib/MPSegment.hpp"
#include "lib/HMMSegment.hpp"
#include "lib/QuerySegment.hpp"
#include "lib/PosTagger.hpp"
#include "lib/Simhasher.hpp"

#include <Rcpp.h>


using namespace Rcpp;
using namespace CppJieba;

inline string itos(double i)  // convert int to string
{
    stringstream s;
    s << i;
    return s.str();
}

inline string int64tos(uint64_t i)  // convert int to string
{
    stringstream s;
    s << i;
    return s.str();
}

class mpseg
{
public:
  const char *const dict_path;
  const char *const user_path;
  MPSegment mpsegment;
  mpseg(CharacterVector dict, CharacterVector user) :
    dict_path(dict[0]), user_path(user[0]), mpsegment(dict_path, user_path)
  {
  }
  ~mpseg() {};
  
  CharacterVector cut(CharacterVector x)
  {
    const char *const test_lines = x[0];
    vector<string> words;
    mpsegment.cut(test_lines, words);
    return wrap(words);
  }
};


class mixseg
{
public:
  const char *const dict_path;
  const char *const model_path;
  const char *const user_path;
  MixSegment mixsegment;
  mixseg(CharacterVector dict, CharacterVector model, CharacterVector user) :
    dict_path(dict[0]), model_path(model[0]), user_path(user[0]), mixsegment(dict_path, model_path, user_path)
  {
  }
  ~mixseg() {};
  
  CharacterVector cut(CharacterVector x)
  {
    const char *const test_lines = x[0];
    vector<string> words;
    mixsegment.cut(test_lines, words);
    return wrap(words);
  }
};


class queryseg
{
public:
  const char *const dict_path;
  const char *const model_path;
  QuerySegment querysegment;
  queryseg(CharacterVector dict, CharacterVector model, int n) :
    dict_path(dict[0]), model_path(model[0]), querysegment(dict_path, model_path, n)
  {
  }
  ~queryseg() {};
  
  CharacterVector cut(CharacterVector x)
  {
    const char *const test_lines = x[0];
    vector<string> words;
    querysegment.cut(test_lines, words);
    return wrap(words);
  }
};


class hmmseg
{
public:
  const char *const model_path;
  HMMSegment hmmsegment;
  hmmseg(CharacterVector model) :
    model_path(model[0]), hmmsegment(model_path)
  {
  }
  ~hmmseg() {};
  
  CharacterVector cut(CharacterVector x)
  {
    const char *const test_lines = x[0];
    vector<string> words;
    hmmsegment.cut(test_lines, words);
    return wrap(words);
  }
};


//////////keyword
class tagger
{
public:
  const char *const dict_path;
  const char *const model_path;
  const char *const user_path;
  PosTagger  taggerseg;
  tagger(CharacterVector dict, CharacterVector model, CharacterVector user) :
    dict_path(dict[0]), model_path(model[0]), user_path(user[0]), taggerseg(dict_path, model_path, user_path)
  {
  }
  ~tagger() {};
  
  CharacterVector tag(CharacterVector x)
  {
    const char *const test_lines = x[0];
    vector<pair<string, string> > res;
    taggerseg.tag(test_lines, res);
    //unsigned int it;
    CharacterVector m(res.size());
    CharacterVector atb(res.size());
    CharacterVector::iterator m_it = m.begin();
    CharacterVector::iterator atb_it = atb.begin();
    for (vector<pair<string, string> >::iterator it = res.begin(); it != res.end(); it++)
    {
      *m_it = (*it).first; m_it++;
      *atb_it = (*it).second; atb_it++;
    }
    m.attr("names") = atb;
    return wrap(m);
  }
  
  CharacterVector file(CharacterVector x)
  {
    const char *const test_lines = x[0];
    vector<pair<string, string> > res;
    taggerseg.tag(test_lines, res);
    //unsigned int it;
    vector<string> m;
    m.reserve(res.size()*2);
    for (vector<pair<string, string> >::iterator it = res.begin(); it != res.end(); it++)
    {
      m.push_back((*it).first);
      m.push_back((*it).second);
    }
    
    return wrap(m);
  }
  
};


class keyword
{
public:
  size_t topN;
  const char *const dict_path;
  const char *const model_path;
  const char *const stop_path;
  const char *const idf_path;
  
  
  
  KeywordExtractor extractor;
  keyword(unsigned int n, CharacterVector dict, CharacterVector model, CharacterVector idf, CharacterVector stop) :
    topN(n), dict_path(dict[0]), model_path(model[0]), stop_path(stop[0]),
    idf_path(idf[0]), extractor(dict_path, model_path, idf_path, stop_path)
  {
  }
  ~keyword() {};
  
  CharacterVector tag(CharacterVector x)
  {
    const char *const test_lines = x[0];
    vector<pair<string, double> > res;
    extractor.extract(test_lines, res, topN);
    //unsigned int it;
    CharacterVector m(res.size());
    CharacterVector atb(res.size());
    CharacterVector::iterator m_it = m.begin();
    CharacterVector::iterator atb_it = atb.begin();
    for (vector<pair<string, double> >::iterator it = res.begin(); it != res.end(); it++)
    {
      *m_it = (*it).first; m_it++;
      *atb_it = itos((*it).second); atb_it++;
    }

    m.attr("names") = atb;
    return wrap(m);
  }
  
  CharacterVector cut(CharacterVector x)
  {
    const char *const test_lines = x[0];
    vector<string> words;
    extractor.extract(test_lines, words, topN);
    return wrap(words);
  }
  
  CharacterVector keys(vector<string>& test_lines)
  {
    vector<pair<string, double> > res;
    extractor.keys(test_lines, res, topN);
    //unsigned int it;
    CharacterVector m(res.size());
    CharacterVector atb(res.size());
    CharacterVector::iterator m_it = m.begin();
    CharacterVector::iterator atb_it = atb.begin();
    for (vector<pair<string, double> >::iterator it = res.begin(); it != res.end(); it++)
    {
      *m_it = (*it).first; m_it++;
      *atb_it = itos((*it).second); atb_it++;
    }
    m.attr("names") = atb;
    return wrap(m);
  }
};



//////////simhash

class sim
{
public:
  const char *const dict_path;
  const char *const model_path;
  const char *const stop_path;
  const char *const idf_path;
  
  Simhash::Simhasher hash;
  sim(CharacterVector dict, CharacterVector model, CharacterVector idf, CharacterVector stop) : dict_path(dict[0]), model_path(model[0]), stop_path(stop[0]),
  idf_path(idf[0]), hash(dict_path, model_path, idf_path, stop_path) {}
  ~sim() {};
  
  List simhash(CharacterVector code, int topn)
  {
    const char *const code_path = code[0];
    vector<pair<string, double> > lhsword;
    uint64_t hashres;
    hash.make(code_path, topn, hashres, lhsword);
    CharacterVector lhsm(lhsword.size());
    CharacterVector lhsatb(lhsword.size());
    //unsigned int it;
    CharacterVector::iterator lhsm_it = lhsm.begin();
    CharacterVector::iterator lhsatb_it = lhsatb.begin();
    for (vector<pair<string, double> >::iterator it = lhsword.begin(); it != lhsword.end(); it++)
    {
      *lhsm_it = (*it).first; lhsm_it++;
      *lhsatb_it = itos((*it).second); lhsatb_it++;
    }
    lhsm.attr("names") = lhsatb;
    CharacterVector hashvec;
    hashvec.push_back(int64tos(hashres));
    return List::create( Named("simhash") = hashvec,
                         Named("keyword") = lhsm);
  }
  
  List distance(CharacterVector lhs, CharacterVector rhs, int topn)
  {
    uint64_t lhsres;
    uint64_t rhsres;
    vector<pair<string, double> > lhsword;
    vector<pair<string, double> > rhsword;
    const char *const lhs_path = lhs[0];
    const char *const rhs_path = rhs[0];
    hash.make(lhs_path, topn, lhsres, lhsword);
    hash.make(rhs_path, topn, rhsres, rhsword);
    CharacterVector lhsm(lhsword.size());
    CharacterVector lhsatb(lhsword.size());
    //unsigned int it;
    CharacterVector::iterator lhsm_it = lhsm.begin();
    CharacterVector::iterator lhsatb_it = lhsatb.begin();
    for (vector<pair<string, double> >::iterator it = lhsword.begin(); it != lhsword.end(); it++)
    {
      *lhsm_it = (*it).first; lhsm_it++;
      *lhsatb_it = itos((*it).second); lhsatb_it++;
    }
    lhsm.attr("names") = lhsatb;
    
    CharacterVector rhsm(rhsword.size());
    CharacterVector rhsatb(rhsword.size());
    CharacterVector::iterator rhsm_it = rhsm.begin();
    CharacterVector::iterator rhsatb_it = rhsatb.begin();
    for (vector<pair<string, double> >::iterator it = rhsword.begin(); it != rhsword.end(); it++)
    {
      *rhsm_it = (*it).first; rhsm_it++;
      *rhsatb_it = itos((*it).second); rhsatb_it++;
    }
    rhsm.attr("names") = rhsatb;

    CharacterVector hashvec;
    hashvec.push_back(int64tos(hash.distances(lhsres, rhsres)));
    return List::create( Named("distance") = hashvec,
                              Named("lhs") = lhsm,
                              Named("rhs") = rhsm
    );
    
  }
  
  
};


#endif