#include "../inst/include/jiebaR.h"
using namespace Rcpp;
//using namespace cppjieba;

// [[Rcpp::export]]
CharacterVector u64tobin(string x){
  string res;
  uint64_t todo = stoull(x.c_str());
  Simhash::Simhasher::toBinaryString(todo,res);
  return wrap(res);
}

// [[Rcpp::export]]
IntegerVector cpp_ham_dist(CharacterVector x, CharacterVector y){
  CharacterVector bigx, bigy;

  if(x.size()>y.size()){
    bigx = x;
    bigy = y;
  } else{
    bigx = y;
    bigy = x;
  }
  auto bigx_size = bigx.size();
  auto bigy_size = bigy.size();

  IntegerVector res(bigx_size);
  
  for(auto it = 0; it != bigx_size; it++){
    uint64_t todox = stoull(R_CHAR(STRING_ELT(bigx, it)));
    uint64_t todoy = stoull(R_CHAR(STRING_ELT(bigy, it % bigy_size)));

    res[it] = Simhash::Simhasher::distances(todox, todoy);
  }
  
  return wrap(res);
}

// [[Rcpp::export]]
IntegerVector cpp_ham_dist_mat(CharacterVector x, CharacterVector y){
  IntegerMatrix res(x.size(), y.size());
  auto x_size = x.size();
  auto y_size = y.size();
  SEXP xx = x;
  SEXP yx = y;
  for(auto it = 0; it != x_size; it++){
    for(auto ij = 0; ij!=y_size; ij++){
      uint64_t todox = stoull(R_CHAR(STRING_ELT(xx, it)));
      uint64_t todoy = stoull(R_CHAR(STRING_ELT(yx, ij)));
      res(it,ij) = Simhash::Simhasher::distances(todox, todoy);
    }
  }
  
  return wrap(res);
}
