#ifndef CPPJIEBA_POS_TAGGING_H
#define CPPJIEBA_POS_TAGGING_H

#include "MixSegment.hpp"
#include "Limonp/StringUtil.hpp"
#include "DictTrie.hpp"
#include "Rcpp.h"
using namespace Rcpp;
namespace CppJieba
{
    using namespace Limonp;

    class PosTagger
    {
        private:
            MixSegment _segment;
            const DictTrie * _dictTrie;

        public:
            PosTagger()
            {}
            PosTagger(
                const string& dictPath, 
                const string& hmmFilePath,
                const string& userDictPath = ""
            )
            {
                init(dictPath, hmmFilePath, userDictPath);
            };
            ~PosTagger(){};
        public:
            void init(
                const string& dictPath, 
                const string& hmmFilePath,
                const string& userDictPath = ""
            )
            {
                LIMONP_CHECK(_segment.init(dictPath, hmmFilePath, userDictPath));
                _dictTrie = _segment.getDictTrie();
                LIMONP_CHECK(_dictTrie);
            };

            bool tag(const string& src, vector<pair<string, string> >& res) const
            {
                vector<string> cutRes;
                if (!_segment.cut(src, cutRes))
                {
                  Rcout<<"_mixSegment cut failed"<<std::endl;
      
                    return false;
                }

                const DictUnit *tmp = NULL;
                Unicode unico;
                for (vector<string>::iterator itr = cutRes.begin(); itr != cutRes.end(); ++itr)
                {
                    if (!TransCode::decode(*itr, unico))
                    {
                      Rcout<<"decode failed."<<std::endl;
        
                        return false;
                    }
                    tmp = _dictTrie->find(unico.begin(), unico.end());
                    res.push_back(make_pair(*itr, tmp == NULL ? "x" : tmp->tag));
                }
                tmp = NULL;
                return !res.empty();
            }
    };
}

#endif
