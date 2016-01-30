#include <R.h>
#define R_NO_REMAP
#include <Rinternals.h>

#include "jiebaRAPI.h"

#define DLLARG(...) __VA_ARGS__

#define DLLFUN(N, B, ...) SEXP api_##N(B){ return N(__VA_ARGS__);}

#define STR(s)     #s

#define REG_DEF(__FUN__,NUM) { STR(api_##__FUN__), (DL_FUNC)& api_##__FUN__,NUM },

#define REG(__FUN__) R_RegisterCCallable( STR(api_##__FUN__), #__FUN__, (DL_FUNC)& api_##__FUN__ );

extern "C" {
// SEXP jiebaR_filecoding(SEXP fileSEXP);
// SEXP api_jiebaR_filecoding(SEXP fileSEXP){ return jiebaR_filecoding(fileSEXP);}
DLLFUN(jiebaR_filecoding,DLLARG(SEXP fileSEXP),fileSEXP)


// SEXP jiebaR_mp_ptr(SEXP dictSEXP, SEXP userSEXP, SEXP stopSEXP); 
DLLFUN(jiebaR_mp_ptr,DLLARG(SEXP dictSEXP, SEXP userSEXP, SEXP stopSEXP),dictSEXP, userSEXP, stopSEXP)

// SEXP jiebaR_mp_cut(SEXP xSEXP, SEXP cutterSEXP);
DLLFUN(jiebaR_mp_cut,DLLARG(SEXP xSEXP, SEXP cutterSEXP),xSEXP, cutterSEXP)
// SEXP jiebaR_mix_cut(SEXP xSEXP, SEXP cutterSEXP);
DLLFUN(jiebaR_mix_cut,DLLARG(SEXP xSEXP, SEXP cutterSEXP),xSEXP, cutterSEXP)
DLLFUN(jiebaR_query_cut,DLLARG(SEXP xSEXP, SEXP cutterSEXP),xSEXP, cutterSEXP)
DLLFUN(jiebaR_hmm_cut,DLLARG(SEXP xSEXP, SEXP cutterSEXP),xSEXP, cutterSEXP)
  

// SEXP jiebaR_mix_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP userSEXP, SEXP stopSEXP);
DLLFUN(jiebaR_mix_ptr,DLLARG(SEXP dictSEXP, SEXP modelSEXP, SEXP userSEXP, SEXP stopSEXP),dictSEXP, modelSEXP, userSEXP, stopSEXP)
  
// SEXP jiebaR_mix_cut(SEXP xSEXP, SEXP cutterSEXP);

// SEXP jiebaR_query_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP nSEXP, SEXP stopSEXP);
DLLFUN(jiebaR_query_ptr,DLLARG(SEXP dictSEXP, SEXP modelSEXP, SEXP nSEXP, SEXP stopSEXP),dictSEXP, modelSEXP, nSEXP, stopSEXP)
  
// SEXP jiebaR_query_cut(SEXP xSEXP, SEXP cutterSEXP);
DLLFUN(jiebaR_hmm_ptr,DLLARG(SEXP modelSEXP, SEXP stopSEXP),modelSEXP, stopSEXP)

// SEXP jiebaR_hmm_ptr(SEXP modelSEXP, SEXP stopSEXP);

// SEXP jiebaR_hmm_cut(SEXP xSEXP, SEXP cutterSEXP);

// SEXP jiebaR_tag_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP userSEXP, SEXP stopSEXP);
DLLFUN(jiebaR_tag_ptr,DLLARG(SEXP dictSEXP, SEXP modelSEXP, SEXP userSEXP, SEXP stopSEXP),dictSEXP, modelSEXP, userSEXP, stopSEXP)

// SEXP jiebaR_tag_tag(SEXP xSEXP, SEXP cutterSEXP);
DLLFUN(jiebaR_tag_tag ,DLLARG(SEXP xSEXP, SEXP cutterSEXP),xSEXP, cutterSEXP)
DLLFUN(jiebaR_tag_file,DLLARG(SEXP xSEXP, SEXP cutterSEXP),xSEXP, cutterSEXP)
DLLFUN(jiebaR_key_tag ,DLLARG(SEXP xSEXP, SEXP cutterSEXP),xSEXP, cutterSEXP)
DLLFUN(jiebaR_key_cut ,DLLARG(SEXP xSEXP, SEXP cutterSEXP),xSEXP, cutterSEXP)
DLLFUN(jiebaR_key_keys,DLLARG(SEXP xSEXP, SEXP cutterSEXP),xSEXP, cutterSEXP)

// SEXP jiebaR_tag_file(SEXP xSEXP, SEXP cutterSEXP);

// SEXP jiebaR_key_ptr(SEXP nSEXP, SEXP dictSEXP, SEXP modelSEXP, SEXP idfSEXP, SEXP stopSEXP);
DLLFUN(jiebaR_key_ptr,DLLARG(SEXP nSEXP, SEXP dictSEXP, SEXP modelSEXP, SEXP idfSEXP, SEXP stopSEXP,SEXP userSEXP),nSEXP,dictSEXP,modelSEXP,idfSEXP,stopSEXP, userSEXP)


// SEXP jiebaR_key_tag(SEXP xSEXP, SEXP cutterSEXP);

// SEXP jiebaR_key_cut(SEXP xSEXP, SEXP cutterSEXP);

// SEXP jiebaR_key_keys(SEXP xSEXP, SEXP cutterSEXP);

// SEXP jiebaR_sim_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP idfSEXP, SEXP stopSEXP);
DLLFUN(jiebaR_sim_ptr,DLLARG(SEXP dictSEXP, SEXP modelSEXP, SEXP idfSEXP, SEXP stopSEXP,SEXP userSEXP),dictSEXP,modelSEXP,idfSEXP,stopSEXP,userSEXP)

// SEXP jiebaR_sim_sim(SEXP codeSEXP, SEXP topnSEXP, SEXP cutterSEXP);
DLLFUN(jiebaR_sim_sim,DLLARG(SEXP codeSEXP, SEXP topnSEXP, SEXP cutterSEXP),codeSEXP,topnSEXP,cutterSEXP)

// SEXP jiebaR_sim_distance(SEXP lhsSEXP, SEXP rhsSEXP, SEXP topnSEXP, SEXP cutterSEXP);
DLLFUN(jiebaR_sim_distance,DLLARG(SEXP lhsSEXP, SEXP rhsSEXP, SEXP topnSEXP, SEXP cutterSEXP),lhsSEXP,rhsSEXP,topnSEXP,cutterSEXP)

  
// v4 
DLLFUN(jiebaR_jiebaclass_ptr,DLLARG(SEXP dictSEXP, SEXP modelSEXP, SEXP userSEXP, SEXP stopSEXP),dictSEXP, modelSEXP, userSEXP, stopSEXP)
DLLFUN(jiebaR_jiebaclass_mix_cut,DLLARG(SEXP xSEXP, SEXP cutterSEXP),xSEXP, cutterSEXP)

}  
  // 
// static R_CallMethodDef callMethods[] = {
//   REG_DEF(jiebaR_filecoding,1)
//   REG_DEF(jiebaR_mp_ptr,3)
//   REG_DEF(jiebaR_mp_cut,2)
//   REG_DEF(jiebaR_mix_cut,2)
//   REG_DEF(jiebaR_hmm_cut,2)
//   REG_DEF(jiebaR_query_cut,2)
//   REG_DEF(jiebaR_mix_ptr,4)
//   REG_DEF(jiebaR_query_ptr,4)
//   REG_DEF(jiebaR_hmm_ptr,2)
//   REG_DEF(jiebaR_tag_ptr,4)
//   REG_DEF(jiebaR_tag_tag,2)
//   REG_DEF(jiebaR_tag_file,2)
//   REG_DEF(jiebaR_key_tag,2)
//   REG_DEF(jiebaR_key_cut,2)
//   REG_DEF(jiebaR_key_keys,2)
//   REG_DEF(jiebaR_key_ptr,6)
//   REG_DEF(jiebaR_sim_ptr,5)
//   REG_DEF(jiebaR_sim_sim,3)
//   REG_DEF(jiebaR_sim_distance,4)
//   //{ "jiebaR_filecoding",  (DL_FUNC) &jiebaR_filecoding    , 1 },
//  { NULL, NULL, 0 }
// };
// 
// 
// extern "C" void R_init_jiebaRapi( DllInfo* info ){
//   R_registerRoutines(info,
//                      NULL,            /* slot for .C */
//                      callMethods,     /* slot for .Call */
//                      NULL,            /* slot for .Fortran */
//                      NULL);           /* slot for .External */
// 
//   R_useDynamicSymbols(info, TRUE);
// 
//   REG(jiebaR_filecoding)
//   REG(jiebaR_mp_ptr)
//   REG(jiebaR_mp_cut)
//   REG(jiebaR_mix_cut)
//   REG(jiebaR_hmm_cut)
//   REG(jiebaR_query_cut)
//   REG(jiebaR_mix_ptr)
//   REG(jiebaR_query_ptr)
//   REG(jiebaR_hmm_ptr)
//   REG(jiebaR_tag_ptr)
//   REG(jiebaR_tag_tag)
//   REG(jiebaR_tag_file)
//   REG(jiebaR_key_tag)
//   REG(jiebaR_key_cut)
//   REG(jiebaR_key_keys)
//   REG(jiebaR_key_ptr)
//   REG(jiebaR_sim_ptr)
//   REG(jiebaR_sim_sim)
//   REG(jiebaR_sim_distance)
// }
