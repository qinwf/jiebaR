#include <Rcpp.h>

#if(__cplusplus == 201103L)

#include <thread>

#endif

using namespace Rcpp;

// Below is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp 
// function (or via the Source button on the editor toolbar)

// For more on using Rcpp click the Help button on the editor toolbar

//' @title Get number of concurrent threads
//' @description Get number of concurrent threads supported by the implementation in C++11.
//' @return number of concurrent threads
//' @references \url{http://en.cppreference.com/w/cpp/thread/thread/hardware_concurrency}
//' @export
// [[Rcpp::export]]
unsigned int get_hardware_concurrency() {
  
  #if(__cplusplus == 201103L) && !defined(__SUNPRO_CC)
  
  return std::thread::hardware_concurrency();
  
  #else
  
   Rcout<< "C++11 is not enabled." << std::endl;
   return 1;
   
  #endif
}


