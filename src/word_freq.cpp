#include <Rcpp.h>

using namespace Rcpp;
using namespace std;
// This is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp 
// function (or via the Source button on the editor toolbar). Learn
// more about Rcpp at:
//
//   http://www.rcpp.org/
//   http://adv-r.had.co.nz/Rcpp.html
//   http://gallery.rcpp.org/
//


// [[Rcpp::export]]
IntegerVector words_freq(const CharacterVector& x) {
  RCPP_UNORDERED_MAP< string, unsigned int > m;
  CharacterVector::const_iterator it = x.begin();
  for(;it != x.end();it++){
    string r = as<string>(*it);
    RCPP_UNORDERED_MAP< string, unsigned int >::iterator m_it = m.find(r);
    if(m_it==m.end()){
      m[r]=1;
    }else{
      (*m_it).second=(*m_it).second+1;
    }

  }
  return wrap(m);
}

