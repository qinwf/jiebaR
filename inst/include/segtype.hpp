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

template <class T> class Seg {
public:
  unordered_set<string> stopWords;
  T cutter;
  
  Seg() = delete;
  Seg(CharacterVector& dict, CharacterVector& model, CharacterVector& user,Nullable<CharacterVector> stop);
  Seg(CharacterVector& dict, CharacterVector& user,Nullable<CharacterVector> stop);
  Seg(CharacterVector& dict, CharacterVector& model, int n,Nullable<CharacterVector> stop);
  Seg(CharacterVector& model,Nullable<CharacterVector> stop);
  ~Seg(){};
  
  CharacterVector cut(CharacterVector& x)
  {
    const char *const test_lines = x[0];
    vector<string> words;
    cutter.cut(test_lines, words);
    if(stopWords.size()==0){
      return wrap(words);
    } else{
      vector<string> res;
      res.reserve(words.size());
      filter_stopwords(res, words,stopWords);
      return wrap(res);
    }
  }
};


//////////keyword
class tagger
{
public:
  const char *const dict_path;
  const char *const model_path;
  const char *const user_path;

  unordered_set<string> stopWords;
  PosTagger  taggerseg;
  tagger(CharacterVector dict, CharacterVector model, CharacterVector user,Nullable<CharacterVector> stop) :
    dict_path(dict[0]), model_path(model[0]), user_path(user[0]), stopWords(unordered_set<string>()), taggerseg(dict_path, model_path, user_path)
  {
  	  	  if(!stop.isNull()){
  	    CharacterVector stop_value = stop.get();
  	 	  const char *const stop_path = stop_value[0];
  	 	  _loadStopWordDict(stop_path,stopWords);
  	 }
  }
  ~tagger() {};
  
  CharacterVector tag(CharacterVector& x)
  {
    const char *const test_lines = x[0];
    vector<pair<string, string> > res;
    taggerseg.tag(test_lines, res);
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
  
  CharacterVector file(CharacterVector& x)
  {
    const char *const test_lines = x[0];
    vector<pair<string, string> > res;
    taggerseg.tag(test_lines, res);
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
  
  CharacterVector tag(CharacterVector& x)
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
  
  CharacterVector cut(CharacterVector& x)
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
  
  List simhash(CharacterVector& code, int topn)
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
  
  List distance(CharacterVector& lhs, CharacterVector& rhs, int topn)
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