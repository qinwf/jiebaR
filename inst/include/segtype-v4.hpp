#ifndef _SEGTYPEV4_HPP_
#define _SEGTYPEV4_HPP_

#include <iostream>
#include <fstream>
#include <cstdlib>
#include <cstdio>
#include <sstream>
#include "lib/Jieba.hpp"
#include "lib/KeywordExtractor.hpp"
#include "lib/Simhasher.hpp"

#include <Rcpp.h>

using namespace Rcpp;
using namespace cppjieba;

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

inline void _loadStopWordDict(const string &filePath,unordered_set<string>& _stopWords)
{
    ifstream ifs(filePath.c_str());
    if (!ifs)
    {
        stop("Open Failed Stop Word Dict segtype.hpp : 40 ");
    }
    string line ;
    while (getline(ifs, line))
    {
        _stopWords.insert(line);
    }
    if (!(_stopWords.size()))
    {
        stop("_stopWords.size() == 0  segtype.hpp : 51 ");
    }

}

inline void filter_stopwords(vector<string>& res,const vector<string>& words,const unordered_set<string>& stopWords){
  for(vector<string>::const_iterator it= words.begin();it != words.end(); it++){
        if (stopWords.end() == stopWords.find(*it))
        {
            res.push_back(*it);
        }
  }
}


inline void filter(const unordered_set<string>& stopWords, vector<string>& words){
    if(stopWords.size()==0){
      return;
    } else{
      vector<string> res;
      res.reserve(words.size());
      filter_stopwords(res, words,stopWords);
      words.swap(res);
    }
}

class JiebaClass {
public:
  unordered_set<string> stopWords;
  cppjieba::Jieba cutter;
  
  JiebaClass() = delete;
  JiebaClass(string& dict, string& model, string& user,Nullable<CharacterVector> stop, DictTrie::UserWordWeightOption uw = DictTrie::UserWordWeightOption::WordWeightMedian)
  : cutter(dict, model, user, uw){
    if(!stop.isNull()){
      CharacterVector stop_value = stop.get();
      const char *const stop_path = stop_value[0];
      _loadStopWordDict(stop_path,stopWords);
    }
  };

  ~JiebaClass(){};
  
  CharacterVector cut_mix(CharacterVector& x)
  {
    const char *const test_lines = x[0];
    vector<string> words;
    cutter.Cut(test_lines, words);
	  filter(stopWords,words);
	  return wrap(words);
  }
  CharacterVector cut_full(CharacterVector& x)
  {
    const char *const test_lines = x[0];
    vector<string> words;
    cutter.CutAll(test_lines, words);
    filter(stopWords,words);
    return wrap(words);
  }
  CharacterVector cut_query(CharacterVector& x)
  {
    const char *const test_lines = x[0];
    vector<string> words;
    cutter.CutForSearch(test_lines, words);
    filter(stopWords,words);
    return wrap(words);
  }
  CharacterVector cut_hmm(CharacterVector& x)
  {
    const char *const test_lines = x[0];
    vector<string> words;
    cutter.CutHMM(test_lines, words);
    filter(stopWords,words);
    return wrap(words);
  }
  CharacterVector cut_mp(CharacterVector& x,size_t maxlen)
  {
    const char *const test_lines = x[0];
    vector<string> words;
    cutter.CutSmall(test_lines, words, maxlen);
    filter(stopWords,words);
    return wrap(words);
  }
  CharacterVector vector_tag(vector<string>& x)
  {
    vector<pair<string, string> > res;
    cutter.SimpleTag(x, res);
    //unsigned int it;
    vector<string> m;
    m.reserve(res.size());
    vector<string> atb;
    atb.reserve(res.size());
    
    if(stopWords.size()>0){
      for (vector<pair<string, string> >::iterator it = res.begin(); it != res.end(); it++)
      {
        
        if (stopWords.end() == stopWords.find((*it).first))
        {
          m.push_back((*it).first);
          atb.push_back((*it).second);
        }
        
      }	
    } else {
      for (vector<pair<string, string> >::iterator it = res.begin(); it != res.end(); it++)
      {
        m.push_back((*it).first);
        atb.push_back((*it).second);
      }
    }
    
    CharacterVector m_cv(m.begin(),m.end());
    CharacterVector atb_cv(atb.begin(),atb.end()); 
    m_cv.attr("names") = atb_cv;
    
    return wrap(m_cv);
    
  }
  CharacterVector cut_tag_tag(CharacterVector& x)
  {
    const char *const test_lines = x[0];
    vector<pair<string, string> > res;
    cutter.Tag(test_lines, res);
    //unsigned int it;
    vector<string> m;
    m.reserve(res.size());
    vector<string> atb;
    atb.reserve(res.size());
    
    if(stopWords.size()>0){
      for (vector<pair<string, string> >::iterator it = res.begin(); it != res.end(); it++)
      {
        
        if (stopWords.end() == stopWords.find((*it).first))
        {
          m.push_back((*it).first);
          atb.push_back((*it).second);
        }
        
      }	
    } else {
      for (vector<pair<string, string> >::iterator it = res.begin(); it != res.end(); it++)
      {
        m.push_back((*it).first);
        atb.push_back((*it).second);
      }
    }
    
    CharacterVector m_cv(m.begin(),m.end());
    CharacterVector atb_cv(atb.begin(),atb.end()); 
    m_cv.attr("names") = atb_cv;
    
    return wrap(m_cv);
    
  }
  CharacterVector cut_tag_file(CharacterVector& x)
  {
    const char *const test_lines = x[0];
    vector<pair<string, string> > res;
    cutter.Tag(test_lines, res);
    //unsigned int it;
    vector<string> m;
    m.reserve(res.size()*2);
    
    if(stopWords.size()>0){
      for (vector<pair<string, string> >::iterator it = res.begin(); it != res.end(); it++)
      {
        
        if (stopWords.end() == stopWords.find((*it).first))
        {
          m.push_back((*it).first);
          m.push_back((*it).second);
        }
        
      }
    }else{
      for (vector<pair<string, string> >::iterator it = res.begin(); it != res.end(); it++)
      {
        m.push_back((*it).first);
        m.push_back((*it).second);
      }
    }
    
    return wrap(m);
  }

  LogicalVector add_user_word(CharacterVector& word, CharacterVector& tag) {
    auto it_tag = tag.begin();
    for(auto it = word.begin();it != word.end();it++){
      if(cutter.InsertUserWord(as<string>(*it),as<string>(*it_tag))!=1){
        warning("%s insert fail.\n",as<string>(*it));
      };
      it_tag++;
    }
    return wrap(1);
  }
};


class keyword
{
public:
  size_t topN;

  KeywordExtractor extractor;
  keyword(unsigned int n, 
          string& dict, 
          string& model, 
          string& idf, 
          string& stop,
          string& user) :
    
    topN(n),
    extractor(dict, model, idf, stop, user)
  {
  }
  ~keyword() {};
  
  CharacterVector tag(CharacterVector& x)
  {
    const char *const test_lines = x[0];
    vector<pair<string, double> > res;
    extractor.Extract(test_lines, res, topN);
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
  
  CharacterVector cut(CharacterVector& x)
  {
    const char *const test_lines = x[0];
    vector<string> words;
    extractor.Extract(test_lines, words, topN);
    return wrap(words);
  }
  
  CharacterVector vector_keys(vector<string>& test_lines)
  {
    vector<pair<string, double> > res;
    extractor.Vector_Extract(test_lines, res, topN);
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


class sim
{
public:

  Simhash::Simhasher hash;
  sim(string& dict, 
      string& model, 
      string& idf, 
      string& stop,
      string& user) :
  hash(dict, model, idf, stop, user) {}
  ~sim() {};
  
  List simhash(string code, size_t topn)
  {
    vector<pair<string, double> > lhsword;
    uint64_t hashres;
    hash.make(code, topn, hashres, lhsword);
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
  
  List simhash_fromvec(vector<string>& code, size_t topn)
  {
    vector<pair<string, double> > lhsword;
    uint64_t hashres;
    hash.make_fromvec(code, topn, hashres, lhsword);
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

  List distance(CharacterVector& lhs, CharacterVector& rhs, size_t topn)
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

    IntegerVector hashvec;
    hashvec.push_back(hash.distances(lhsres, rhsres));
    return List::create( Named("distance") = hashvec,
                              Named("lhs") = lhsm,
                              Named("rhs") = rhsm
    );
    
  }
  
  List distance_fromvec(vector<string>& lhs_path , vector<string>& rhs_path, size_t topn)
  {
    uint64_t lhsres;
    uint64_t rhsres;
    vector<pair<string, double> > lhsword;
    vector<pair<string, double> > rhsword;

    hash.make_fromvec(lhs_path, topn, lhsres, lhsword);
    hash.make_fromvec(rhs_path, topn, rhsres, rhsword);
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

    IntegerVector hashvec;

    hashvec.push_back(hash.distances(lhsres, rhsres));
    return List::create( Named("distance") = hashvec,
                              Named("lhs") = lhsm,
                              Named("rhs") = rhsm
    );
    
  }
};



#endif
