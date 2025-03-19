#include <Rcpp.h>
using namespace Rcpp;

// This is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp 
// function (or via the Source button on the editor toolbar). Learn
// more about Rcpp at:
//
//   http://www.rcpp.org/
//   http://adv-r.had.co.nz/Rcpp.html
//   http://gallery.rcpp.org/
//

using namespace std;

string get_string(CharacterVector::iterator begin,CharacterVector::iterator end){
  std::string s;
  for (CharacterVector::iterator i = begin; i != end; ++i){
    s += *i;
  }

  return s;
}

void get_tuple_void(CharacterVector& x,unsigned int step,std::unordered_map< string, unsigned int >& m) {
  
  for(CharacterVector::iterator it = x.begin();it+step-1 != x.end();it++){
    string r = get_string(it,it+step);
    std::unordered_map< string, unsigned int >::iterator m_it = m.find(r);
    if(m_it==m.end()){
      m[r]=1;
    }else{
      (*m_it).second=(*m_it).second+1;
    }
  }
  
}

// [[Rcpp::export]]
List get_tuple_list(ListOf<CharacterVector> x,R_xlen_t step) {
  std::unordered_map< string, unsigned int > res;
  for(ListOf<CharacterVector>::iterator it = x.begin();it != x.end();it++){
    for(R_xlen_t cnt=2;cnt<=step;cnt++){
      CharacterVector tmp = as<CharacterVector>(*it);
      if(tmp.size()<= cnt) continue;
      get_tuple_void(tmp,cnt,res);
    }
  }
  return wrap(res);
}

// [[Rcpp::export]]
List get_tuple_vector(CharacterVector& x,R_xlen_t step) {
  std::unordered_map< string, unsigned int > res;
  for(R_xlen_t cnt=2;cnt<=step;cnt++){
    get_tuple_void(x,cnt,res);
  }
  return wrap(res);
}

// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//
