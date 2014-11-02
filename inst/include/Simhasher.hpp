#ifndef SIMHASH_SIMHASHER_HPP
#define SIMHASH_SIMHASHER_HPP

#include "KeywordExtractor.hpp"
#include "hashes/jenkins.h"
#include "Rcpp.h"
using namespace Rcpp;
namespace Simhash
{
    using namespace CppJieba;
    class Simhasher: public NonCopyable
    {
        private:
            enum{BITS_LENGTH = 64};
            jenkins _hasher;
            KeywordExtractor _extractor;
        public:
            Simhasher(const string& dictPath, const string& modelPath, const string& idfPath, const string& stopWords): _extractor(dictPath, modelPath, idfPath, stopWords)
            {}
            ~Simhasher(){};
        public:
            bool extract(const string& text, vector<pair<string,double> > & res, size_t topN) const
            {
                return _extractor.extract(text, res, topN);
            }
            bool make(const string& text, size_t topN, vector<pair<uint64_t, double> >& res, vector<pair<string, double> >& wordweights) const
            {
                
                if(!extract(text, wordweights, topN))
                {
                  Rcout<<"extract failed."<<std::endl;

                    return false;
                }
                res.resize(wordweights.size());
                for(size_t i = 0; i < res.size(); i++)
                {
                    res[i].first = _hasher(wordweights[i].first.c_str(), wordweights[i].first.size(), 0);
                    res[i].second = wordweights[i].second;
                }

                return true;
            }

            bool make(const string& text, size_t topN, uint64_t& v64,vector<pair<string, double> >& wordweights) const
            {
                vector<pair<uint64_t, double> > hashvalues;
                if(!make(text, topN, hashvalues,wordweights))
                {
                    return false;
                }
                vector<double> weights(BITS_LENGTH, 0.0);
                const uint64_t u64_1(1);
                for(size_t i = 0; i < hashvalues.size(); i++)
                {
                    for(size_t j = 0; j < BITS_LENGTH; j++)
                    {
                        weights [j] += (((u64_1 << j) & hashvalues[i].first) ? 1: -1) * hashvalues[i].second;
                    }
                }

                v64 = 0;
                for(size_t j = 0; j < BITS_LENGTH; j++)
                {
                    if(weights[j] > 0.0)
                    {
                        v64 |= (u64_1 << j);
                    }
                }
                
                return true;
            }
            
            static bool isEqual(uint64_t lhs, uint64_t rhs, unsigned short n = 3)
            {
                unsigned short cnt = 0;
                lhs ^= rhs;
                while(lhs && cnt <= n)
                {
                    lhs &= lhs - 1;
                    cnt++;
                }
                if(cnt <= n)
                {
                    return true;
                }
                return false;
            }

            static void toBinaryString(uint64_t req, string& res)
            {
                res.resize(64);
                for(signed i = 63; i >= 0; i--)
                {
                    req & 1 ? res[i] = '1' : res[i] = '0';
                    req >>= 1;
                }
            }

            static uint64_t binaryStringToUint64(const string& bin)
            {
                uint64_t res = 0;
                for(size_t i = 0; i < bin.size(); i++)
                {
                    res <<= 1;
                    if(bin[i] == '1')
                    {
                        res += 1;
                    }
                }
                return res;
            }
            static uint64_t distances(uint64_t lhs, uint64_t rhs)
            {
                uint64_t cnt = 0;
                lhs ^= rhs;
                while(lhs != 0)
                {
                    lhs &= lhs - 1;
                    cnt++;
                }
                
                return cnt;
            }

    };
}

#endif


