#include <jiebaR.h>
using namespace Rcpp;
using namespace CppJieba;

/////// mpseg

// [[Rcpp::export]]
XPtr<mpseg> mp_ptr(const CharacterVector& dict, const CharacterVector& user,const Nullable<CharacterVector>& stop){
  return( XPtr<mpseg>(new mpseg(dict, user, stop))) ;
}


// [[Rcpp::export]]
CharacterVector mp_cut(CharacterVector& x, XPtr<mpseg> cutter){
  return wrap(cutter->cut(x));
}


///////// async

// [[Rcpp::export]]
SEXP mix_cut_async(CharacterVector& x, XPtr<mixseg> cutter){
  return cutter->cut_async(x);
}

// [[Rcpp::export]]
List hmm_cut_async(CharacterVector& x, XPtr<hmmseg> cutter){
  return wrap(cutter->cut_async(x));
}

// [[Rcpp::export]]
List query_cut_async(CharacterVector& x, XPtr<queryseg> cutter){
  return wrap(cutter->cut_async(x));
}

// [[Rcpp::export]]
List mp_cut_async(CharacterVector& x, XPtr<mpseg> cutter){
  return wrap(cutter->cut_async(x));
}

/////// mixseg

// [[Rcpp::export]]
XPtr<mixseg> mix_ptr(const CharacterVector& dict, const CharacterVector& model,
                     const CharacterVector& user,const Nullable<CharacterVector>& stop){
  return( XPtr<mixseg>(new mixseg(dict, model, user, stop))) ;
}

// [[Rcpp::export]]
CharacterVector mix_cut(CharacterVector& x, XPtr<mixseg> cutter){
  return wrap(cutter->cut(x));
}

/////// queryseg

// [[Rcpp::export]]
XPtr<queryseg> query_ptr(const CharacterVector& dict, const CharacterVector& model,
                         const int& n,const Nullable<CharacterVector>& stop){
  return( XPtr<queryseg>(new queryseg(dict, model, n,stop))) ;
}

// [[Rcpp::export]]
CharacterVector query_cut(CharacterVector& x, XPtr<queryseg> cutter){
  return wrap(cutter->cut(x));
}

/////// hmmseg

// [[Rcpp::export]]
XPtr<hmmseg> hmm_ptr(const CharacterVector& model,const Nullable<CharacterVector>& stop){
  const char *const model_path = model[0];
  return( XPtr<hmmseg>(new hmmseg(model_path,stop))) ;
}

// [[Rcpp::export]]
CharacterVector hmm_cut(CharacterVector& x, XPtr<hmmseg> cutter){
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
