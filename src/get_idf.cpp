#include <Rcpp.h>
#include <jiebaR.h>

using namespace Rcpp;
using namespace std;
typedef RCPP_UNORDERED_MAP< string, pair<unsigned int,unsigned int > > IDFmap;

void inner_find(CharacterVector& y,IDFmap& m,unsigned int dis){
  for(CharacterVector::iterator it = y.begin();it!=y.end();it++){
    string tmp = as<string>(*it);
    IDFmap::iterator m_it = m.find(tmp);
    if(m_it==m.end()){
      m[tmp].first=dis;
      m[tmp].second=1;
    }else{
      if((*m_it).second.first != dis){
        (*m_it).second.first = dis;
        (*m_it).second.second =(*m_it).second.second+1;
      }
    }
  }
}

// [[Rcpp::export]]
List get_idf_cpp(List x,Nullable<CharacterVector> stop_) {

  IDFmap m;
  for(ListOf<CharacterVector>::iterator it = x.begin();it != x.end();it++){
    unsigned int dis = distance( x.begin(), it );
    auto tmp = as<CharacterVector>(*it);
    inner_find(tmp,m,dis);
  }
  RCPP_UNORDERED_MAP< string,unsigned int > res;
  
  
  unordered_set<string> st;
  
  if(!stop_.isNull()){
    CharacterVector stop_value = stop_.get();
    const char *const stop_path = stop_value[0];
    _loadStopWordDict(stop_path,st);
    for(auto its= m.begin();its!=m.end();its++){
      if(st.find((*its).first) ==st.end()) res[(*its).first] = (*its).second.second;
    }
    return wrap(res);
  }
  
  for(auto its= m.begin();its!=m.end();its++){
    res[(*its).first] = (*its).second.second;
  }
  return wrap(res);
}
