#include <jiebaR.h>
using namespace Rcpp;
using namespace CppJieba;

/////// mpseg

// [[Rcpp::export]]
XPtr<mpseg> mp_ptr(const CharacterVector& dict, const CharacterVector& user){
  return( XPtr<mpseg>(new mpseg(dict, user))) ;
}


// [[Rcpp::export]]
CharacterVector mp_cut(const CharacterVector& x, XPtr<mpseg> cutter){
  return wrap(cutter->cut(x));
}

/////// mixseg

// [[Rcpp::export]]
XPtr<mixseg> mix_ptr(const CharacterVector& dict, const CharacterVector& model,
                     const CharacterVector& user){
  return( XPtr<mixseg>(new mixseg(dict, model, user))) ;
}

// [[Rcpp::export]]
CharacterVector mix_cut(const CharacterVector& x, XPtr<mixseg> cutter){
  return wrap(cutter->cut(x));
}

/////// queryseg

// [[Rcpp::export]]
XPtr<queryseg> query_ptr(const CharacterVector& dict, const CharacterVector& model,
                         const int& n){
  return( XPtr<queryseg>(new queryseg(dict, model, n))) ;
}

// [[Rcpp::export]]
CharacterVector query_cut(const CharacterVector& x, XPtr<queryseg> cutter){
  return wrap(cutter->cut(x));
}

/////// hmmseg

// [[Rcpp::export]]
XPtr<hmmseg> hmm_ptr(const CharacterVector& model){
  const char *const model_path = model[0];
  return( XPtr<hmmseg>(new hmmseg(model_path))) ;
}

// [[Rcpp::export]]
CharacterVector hmm_cut(const CharacterVector& x, XPtr<hmmseg> cutter){
  return wrap(cutter->cut(x));
}

/////// tagger


// [[Rcpp::export]]
XPtr<tagger> tag_ptr(const CharacterVector& dict, const CharacterVector& model,
                     const CharacterVector& user){
  return( XPtr<tagger>(new tagger(dict, model, user))) ;
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
