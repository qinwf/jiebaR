// -*-c++-*-
#ifndef _JIEBAR_H_
#define _JIEBAR_H_

#include <segtype-v4.hpp>

#include <Rcpp.h>

// v3
/////// keyword

XPtr<keyword> key_ptr(unsigned int& n, string dict, string model, string idf, string stop,string user);

CharacterVector key_tag(CharacterVector& x, XPtr<keyword> cutter);

CharacterVector key_cut(CharacterVector& x, XPtr<keyword> cutter);

CharacterVector key_keys(vector<string>& x, XPtr<keyword> cutter);

/////// simhash

XPtr<sim> sim_ptr(string dict, string model,
                  string idf,  string stop, string user);

List sim_sim(string code, size_t topn, XPtr<sim> cutter);

List sim_vec(vector<string>& code, size_t topn, XPtr<sim> cutter);

List sim_distance(CharacterVector& lhs, CharacterVector& rhs, size_t topn, XPtr<sim> cutter);

List sim_distance_vec(vector<string>& lcode,vector<string>& rcode, size_t topn, XPtr<sim> cutter);


// v4

XPtr<JiebaClass> jiebaclass_ptr(string dict, string model, string user,Nullable<CharacterVector>& stop);

XPtr<JiebaClass> jiebaclass_ptr_v2(string dict, string model, string user,Nullable<CharacterVector>& stop, int uw);

CharacterVector jiebaclass_mix_cut(CharacterVector& x, XPtr<JiebaClass> cutter);

CharacterVector jiebaclass_mp_cut(CharacterVector& x, size_t num,XPtr<JiebaClass> cutter);

CharacterVector jiebaclass_hmm_cut(CharacterVector& x, XPtr<JiebaClass> cutter);

CharacterVector jiebaclass_full_cut(CharacterVector& x, XPtr<JiebaClass> cutter);

CharacterVector jiebaclass_query_cut(CharacterVector& x, XPtr<JiebaClass> cutter);

CharacterVector jiebaclass_tag_tag(CharacterVector& x, XPtr<JiebaClass> cutter);

CharacterVector jiebaclass_tag_file(CharacterVector& x, XPtr<JiebaClass> cutter);

SEXP add_user_word(CharacterVector& x,CharacterVector& tag, XPtr<JiebaClass> cutter);


CharacterVector u64tobin(string x);



#endif
