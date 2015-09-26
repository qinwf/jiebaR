#include <jiebaR.h>
using namespace Rcpp;
using namespace CppJieba;

/////// mpseg


///Mix
template<> Seg<MixSegment>::Seg(CharacterVector dict, CharacterVector model, CharacterVector user,Nullable<CharacterVector> stop) // String<C>’s constr uctor
  :stopWords(unordered_set<string>()), cutter(as<string>(dict),as<string>(model),as<string>(user))
{
  if(!stop.isNull()){
    CharacterVector stop_value = stop.get();
    const char *const stop_path = stop_value[0];
    _loadStopWordDict(stop_path,stopWords);
  }
}
template<> Seg<MixSegment>::Seg(CharacterVector dict, CharacterVector user,Nullable<CharacterVector> stop) = delete;
template<> Seg<MixSegment>::Seg(CharacterVector dict, CharacterVector model, int n,Nullable<CharacterVector> stop) = delete;
template<> Seg<MixSegment>::Seg(CharacterVector model,Nullable<CharacterVector> stop) = delete;

///MP
template<> Seg<MPSegment>::Seg(CharacterVector dict, CharacterVector model, CharacterVector user,Nullable<CharacterVector> stop) =delete;
template<> Seg<MPSegment>::Seg(CharacterVector dict, CharacterVector user,Nullable<CharacterVector> stop): stopWords(unordered_set<string>()), cutter(as<string>(dict),as<string>(user)){
    if(!stop.isNull()){
    CharacterVector stop_value = stop.get();
    const char *const stop_path = stop_value[0];
    _loadStopWordDict(stop_path,stopWords);
  }
}
template<> Seg<MPSegment>::Seg(CharacterVector dict, CharacterVector model, int n,Nullable<CharacterVector> stop) = delete;
template<> Seg<MPSegment>::Seg(CharacterVector model,Nullable<CharacterVector> stop) = delete;

///qu
template<> Seg<QuerySegment>::Seg(CharacterVector dict, CharacterVector model, CharacterVector user,Nullable<CharacterVector> stop) =delete;
template<> Seg<QuerySegment>::Seg(CharacterVector dict, CharacterVector user,Nullable<CharacterVector> stop) = delete;
template<> Seg<QuerySegment>::Seg(CharacterVector dict, CharacterVector model, int n,Nullable<CharacterVector> stop) : stopWords(unordered_set<string>()), cutter(as<string>(dict),as<string>(model),n){
    if(!stop.isNull()){
      CharacterVector stop_value = stop.get();
      const char *const stop_path = stop_value[0];
      _loadStopWordDict(stop_path,stopWords);
  }
};
template<> Seg<QuerySegment>::Seg(CharacterVector model,Nullable<CharacterVector> stop) = delete;

///hmm
template<> Seg<HMMSegment>::Seg(CharacterVector dict, CharacterVector model, CharacterVector user,Nullable<CharacterVector> stop) =delete;
template<> Seg<HMMSegment>::Seg(CharacterVector dict, CharacterVector user,Nullable<CharacterVector> stop) = delete;
template<> Seg<HMMSegment>::Seg(CharacterVector dict, CharacterVector model, int n,Nullable<CharacterVector> stop) = delete;
template<> Seg<HMMSegment>::Seg(CharacterVector model,Nullable<CharacterVector> stop):stopWords(unordered_set<string>()), cutter(as<string>(model)){
    if(!stop.isNull()){
      CharacterVector stop_value = stop.get();
      const char *const stop_path = stop_value[0];
      _loadStopWordDict(stop_path,stopWords);
    }
};



// [[Rcpp::export]]
XPtr<Seg<MPSegment>> mp_ptr(const CharacterVector& dict, const CharacterVector& user,const Nullable<CharacterVector>& stop){
  return( XPtr<Seg<MPSegment>>(new Seg<MPSegment>(dict, user, stop))) ;
}


// [[Rcpp::export]]
CharacterVector mp_cut(CharacterVector& x, XPtr<Seg<MPSegment>> cutter){
  return wrap(cutter->cut(x));
}


///////// async

// [[Rcpp::export]]
SEXP mix_cut_async(CharacterVector& x, XPtr<Seg<MixSegment>> cutter){
  return cutter->cut_async(x);
}

// [[Rcpp::export]]
List hmm_cut_async(CharacterVector& x, XPtr<Seg<HMMSegment>> cutter){
  return wrap(cutter->cut_async(x));
}

// [[Rcpp::export]]
List query_cut_async(CharacterVector& x, XPtr<Seg<QuerySegment>> cutter){
  return wrap(cutter->cut_async(x));
}

// [[Rcpp::export]]
List mp_cut_async(CharacterVector& x, XPtr<Seg<MPSegment>> cutter){
  return wrap(cutter->cut_async(x));
}

/////// mixseg

// [[Rcpp::export]]
XPtr<Seg<MixSegment>> mix_ptr(const CharacterVector& dict, const CharacterVector& model,
                     const CharacterVector& user,const Nullable<CharacterVector>& stop){
  return( XPtr<Seg<MixSegment>>(new Seg<MixSegment>(dict, model, user, stop))) ;
}

// [[Rcpp::export]]
CharacterVector mix_cut(CharacterVector& x, XPtr<Seg<MixSegment>> cutter){
  return wrap(cutter->cut(x));
}

/////// queryseg

// [[Rcpp::export]]
XPtr<Seg<QuerySegment>> query_ptr(const CharacterVector& dict, const CharacterVector& model,
                         const int& n,const Nullable<CharacterVector>& stop){
  return( XPtr<Seg<QuerySegment>>(new Seg<QuerySegment>(dict, model, n,stop))) ;
}

// [[Rcpp::export]]
CharacterVector query_cut(CharacterVector& x, XPtr<Seg<QuerySegment>> cutter){
  return wrap(cutter->cut(x));
}

/////// hmmseg

// [[Rcpp::export]]
XPtr<Seg<HMMSegment>> hmm_ptr(const CharacterVector& model,const Nullable<CharacterVector>& stop){
  const char *const model_path = model[0];
  return( XPtr<Seg<HMMSegment>>(new Seg<HMMSegment>(model_path,stop))) ;
}

// [[Rcpp::export]]
CharacterVector hmm_cut(CharacterVector& x, XPtr<Seg<HMMSegment>> cutter){
  return wrap(cutter->cut(x));
}

/////// tagger


// [[Rcpp::export]]
XPtr<tagger> tag_ptr(const CharacterVector& dict, const CharacterVector& model,
                     const CharacterVector& user,  const Nullable<CharacterVector>& stop){
  return( XPtr<tagger>(new tagger(dict, model, user, stop))) ;
}

// [[Rcpp::export]]
CharacterVector tag_tag(const CharacterVector& x, XPtr<tagger> cutter){
  return wrap(cutter->tag(x));
}

// [[Rcpp::export]]
CharacterVector tag_file(const CharacterVector& x, XPtr<tagger> cutter){
  return wrap(cutter->file(x));
}

/////// keyword

// [[Rcpp::export]]
XPtr<keyword> key_ptr(const unsigned int& n, const CharacterVector& dict,
                      const CharacterVector& model, const CharacterVector& idf,
                      const CharacterVector& stop){
  return( XPtr<keyword>(new keyword(n, dict, model, idf, stop))) ;
}

// [[Rcpp::export]]
CharacterVector key_tag(const CharacterVector& x, XPtr<keyword> cutter){
  return wrap(cutter->tag(x));
}

// [[Rcpp::export]]
CharacterVector key_cut(const CharacterVector& x, XPtr<keyword> cutter){
  return wrap(cutter->cut(x));
}

// [[Rcpp::export]]
CharacterVector key_keys(vector<string>& x, XPtr<keyword> cutter){
  return wrap(cutter->keys(x));
}

/////// simhash

// [[Rcpp::export]]
XPtr<sim> sim_ptr(const CharacterVector& dict, const CharacterVector& model,
                  const CharacterVector& idf,  const CharacterVector& stop){
  return( XPtr<sim>(new sim(dict, model, idf, stop))) ;
}

// [[Rcpp::export]]
List sim_sim(const CharacterVector& code, const int& topn, XPtr<sim> cutter){
  return cutter->simhash(code,topn);
}
  
  
// [[Rcpp::export]]
List sim_distance(const CharacterVector& lhs, const CharacterVector& rhs,
                  const int& topn, XPtr<sim> cutter){
  return cutter->distance(lhs, rhs, topn);
}
