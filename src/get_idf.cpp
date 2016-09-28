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


  
  vector<string> sts;
  vector<double> stn;
  sts.reserve(m.size());
  stn.reserve(m.size());
  
  unordered_set<string> st;

  double xsize = x.size();
  
  if(!stop_.isNull()){
    CharacterVector stop_value = stop_.get();
    const char *const stop_path = stop_value[0];
    _loadStopWordDict(stop_path,st);
    for(auto its= m.begin();its!=m.end();its++){
      if(st.find((*its).first) ==st.end()){
        sts.push_back((*its).first);
        stn.push_back( log(xsize / (*its).second.second) );
      }
    }

  }else{
    for(auto its= m.begin();its!=m.end();its++){
      sts.push_back((*its).first);
      stn.push_back((*its).second.second);
    }
  }
  
  vector<string> row_names;
  row_names.reserve(sts.size());
  for (unsigned int i = 1; i <= sts.size(); ++i) {
    row_names.emplace_back(int64tos(i));
  }
  
  List res = List::create(_["name"] = wrap(sts),_["count"] = wrap(stn));
  res.attr("row.names") = row_names;
  res.attr("names") = CharacterVector::create("name","count");
  res.attr("class") = "data.frame";
  return res;
}
