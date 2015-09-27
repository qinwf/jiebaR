#include <jiebaR.h>
using namespace Rcpp;
using namespace CppJieba;

///Mix
template<> Seg<MixSegment>::Seg(CharacterVector& dict, CharacterVector& model, CharacterVector& user,Nullable<CharacterVector> stop) // String<C>’s constr uctor
  :stopWords(unordered_set<string>()), cutter(as<string>(dict),as<string>(model),as<string>(user))
{
  if(!stop.isNull()){
    CharacterVector stop_value = stop.get();
    const char *const stop_path = stop_value[0];
    _loadStopWordDict(stop_path,stopWords);
  }
}

///MP
template<> Seg<MPSegment>::Seg(CharacterVector& dict, CharacterVector& user,Nullable<CharacterVector> stop): stopWords(unordered_set<string>()), cutter(as<string>(dict),as<string>(user)){
    if(!stop.isNull()){
    CharacterVector stop_value = stop.get();
    const char *const stop_path = stop_value[0];
    _loadStopWordDict(stop_path,stopWords);
  }
}

///qu
template<> Seg<QuerySegment>::Seg(CharacterVector& dict, CharacterVector& model, int n,Nullable<CharacterVector> stop) : stopWords(unordered_set<string>()), cutter(as<string>(dict),as<string>(model),n){
    if(!stop.isNull()){
      CharacterVector stop_value = stop.get();
      const char *const stop_path = stop_value[0];
      _loadStopWordDict(stop_path,stopWords);
  }
};

///hmm
template<> Seg<HMMSegment>::Seg(CharacterVector& model,Nullable<CharacterVector> stop):stopWords(unordered_set<string>()), cutter(as<string>(model)){
    if(!stop.isNull()){
      CharacterVector stop_value = stop.get();
      const char *const stop_path = stop_value[0];
      _loadStopWordDict(stop_path,stopWords);
    }
};



// [[Rcpp::export]]
XPtr<Seg<MPSegment>> mp_ptr(CharacterVector& dict, CharacterVector& user, Nullable<CharacterVector>& stop){
  return( XPtr<Seg<MPSegment>>(new Seg<MPSegment>(dict, user, stop))) ;
}


// [[Rcpp::export]]
CharacterVector mp_cut(CharacterVector& x, XPtr<Seg<MPSegment>> cutter){
  return wrap(cutter->cut(x));
}

/////// mixseg

// [[Rcpp::export]]
XPtr<Seg<MixSegment>> mix_ptr(CharacterVector& dict, CharacterVector& model,
                     CharacterVector& user,Nullable<CharacterVector>& stop){
  return( XPtr<Seg<MixSegment>>(new Seg<MixSegment>(dict, model, user, stop))) ;
}

// [[Rcpp::export]]
CharacterVector mix_cut(CharacterVector& x, XPtr<Seg<MixSegment>> cutter){
  return wrap(cutter->cut(x));
}

/////// queryseg

// [[Rcpp::export]]
XPtr<Seg<QuerySegment>> query_ptr(CharacterVector& dict, CharacterVector& model,
                         int& n,Nullable<CharacterVector>& stop){
  return( XPtr<Seg<QuerySegment>>(new Seg<QuerySegment>(dict, model, n,stop))) ;
}

// [[Rcpp::export]]
CharacterVector query_cut(CharacterVector& x, XPtr<Seg<QuerySegment>> cutter){
  return wrap(cutter->cut(x));
}

/////// hmmseg

// [[Rcpp::export]]
XPtr<Seg<HMMSegment>> hmm_ptr(CharacterVector& model,Nullable<CharacterVector>& stop){
  return( XPtr<Seg<HMMSegment>>(new Seg<HMMSegment>(model,stop))) ;
}

// [[Rcpp::export]]
CharacterVector hmm_cut(CharacterVector& x, XPtr<Seg<HMMSegment>> cutter){
  return wrap(cutter->cut(x));
}

/////// tagger


// [[Rcpp::export]]
XPtr<tagger> tag_ptr(CharacterVector& dict, CharacterVector& model,
                     CharacterVector& user,  Nullable<CharacterVector>& stop){
  return( XPtr<tagger>(new tagger(dict, model, user, stop))) ;
}

// [[Rcpp::export]]
CharacterVector tag_tag(CharacterVector& x, XPtr<tagger> cutter){
  return wrap(cutter->tag(x));
}

// [[Rcpp::export]]
CharacterVector tag_file(CharacterVector& x, XPtr<tagger> cutter){
  return wrap(cutter->file(x));
}

/////// keyword

// [[Rcpp::export]]
XPtr<keyword> key_ptr(unsigned int& n, CharacterVector& dict,
                      CharacterVector& model, CharacterVector& idf,
                      CharacterVector& stop){
  return( XPtr<keyword>(new keyword(n, dict, model, idf, stop))) ;
}

// [[Rcpp::export]]
CharacterVector key_tag(CharacterVector& x, XPtr<keyword> cutter){
  return wrap(cutter->tag(x));
}

// [[Rcpp::export]]
CharacterVector key_cut(CharacterVector& x, XPtr<keyword> cutter){
  return wrap(cutter->cut(x));
}

// [[Rcpp::export]]
CharacterVector key_keys(vector<string>& x, XPtr<keyword> cutter){
  return wrap(cutter->keys(x));
}

/////// simhash

// [[Rcpp::export]]
XPtr<sim> sim_ptr(CharacterVector& dict, CharacterVector& model,
                  CharacterVector& idf,  CharacterVector& stop){
  return( XPtr<sim>(new sim(dict, model, idf, stop))) ;
}

// [[Rcpp::export]]
List sim_sim(CharacterVector& code, int& topn, XPtr<sim> cutter){
  return cutter->simhash(code,topn);
}
  
  
// [[Rcpp::export]]
List sim_distance(CharacterVector& lhs, CharacterVector& rhs,
                  int& topn, XPtr<sim> cutter){
  return cutter->distance(lhs, rhs, topn);
}
