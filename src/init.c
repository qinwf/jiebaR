
#include <Rconfig.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>

// v3
SEXP _jiebaR_file_coding(SEXP fileSEXP);

SEXP _jiebaR_key_ptr(SEXP nSEXP, SEXP dictSEXP, SEXP modelSEXP, SEXP idfSEXP, SEXP stopSEXP, SEXP userSEXP);

SEXP _jiebaR_key_tag(SEXP xSEXP, SEXP cutterSEXP);

SEXP _jiebaR_key_cut(SEXP xSEXP, SEXP cutterSEXP);

SEXP _jiebaR_key_keys(SEXP xSEXP, SEXP cutterSEXP);

SEXP _jiebaR_sim_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP idfSEXP, SEXP stopSEXP, SEXP userSEXP);

SEXP _jiebaR_sim_sim(SEXP codeSEXP, SEXP topnSEXP, SEXP cutterSEXP);

SEXP _jiebaR_sim_distance(SEXP lhsSEXP, SEXP rhsSEXP, SEXP topnSEXP, SEXP cutterSEXP);

SEXP _jiebaR_words_freq(SEXP x);


// new v4
// 
SEXP _jiebaR_jiebaclass_ptr(SEXP dict, SEXP model, SEXP user,SEXP stop);

// 
SEXP _jiebaR_jiebaclass_ptr_v2(SEXP dict, SEXP model, SEXP user,SEXP stop, SEXP uw);


SEXP _jiebaR_jiebaclass_mix_cut(SEXP x, SEXP cutter);

SEXP _jiebaR_jiebaclass_mp_cut(SEXP x, SEXP num,SEXP cutter);

SEXP _jiebaR_jiebaclass_hmm_cut(SEXP x, SEXP cutter);

SEXP _jiebaR_jiebaclass_full_cut(SEXP x, SEXP cutter);

SEXP _jiebaR_jiebaclass_query_cut(SEXP x, SEXP cutter);

SEXP _jiebaR_jiebaclass_tag_tag(SEXP x, SEXP cutter);

SEXP _jiebaR_jiebaclass_tag_file(SEXP x, SEXP cutter);

SEXP _jiebaR_jiebaclass_tag_vec(SEXP x, SEXP cutter);


SEXP _jiebaR_add_user_word(SEXP x,SEXP tag, SEXP cutter);

SEXP _jiebaR_u64tobin(SEXP x);
  
// wrap
SEXP _jiebaR_mp_ptr(SEXP dictSEXP, SEXP userSEXP, SEXP stopSEXP){
  Rf_warning("_jiebaR_mp_ptr has been removed, please used _jiebaR_jiebaclass_ptr");
  return R_NilValue;
}

SEXP _jiebaR_mp_cut(SEXP xSEXP, SEXP cutterSEXP){
  Rf_warning("_jiebaR_mp_cut has been removed, please used _jiebaR_jiebaclass_mp_cut");
  return R_NilValue;
}

SEXP _jiebaR_mix_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP userSEXP, SEXP stopSEXP){
  Rf_warning("_jiebaR_mix_ptr has been removed, please used _jiebaR_jiebaclass_ptr");
  return _jiebaR_jiebaclass_ptr(dictSEXP, modelSEXP, userSEXP, stopSEXP);
}

SEXP _jiebaR_mix_cut(SEXP xSEXP, SEXP cutterSEXP){
  Rf_warning("_jiebaR_mix_cut has been removed, please used _jiebaR_jiebaclass_mix_cut");
  return _jiebaR_jiebaclass_mix_cut(xSEXP, cutterSEXP);
}


SEXP _jiebaR_query_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP nSEXP, SEXP stopSEXP){
  Rf_warning("_jiebaR_query_ptr has been removed, please used _jiebaR_jiebaclass_ptr");
  return R_NilValue;
}

SEXP _jiebaR_query_cut(SEXP xSEXP, SEXP cutterSEXP){
  Rf_warning("_jiebaR_query_cut has been removed, please used _jiebaR_jiebaclass_query_cut");
  return R_NilValue;
}

SEXP _jiebaR_hmm_ptr(SEXP modelSEXP, SEXP stopSEXP){
  Rf_warning("_jiebaR_hmm_ptr has been removed, please used _jiebaR_jiebaclass_ptr");
  return R_NilValue;
}

SEXP _jiebaR_hmm_cut(SEXP xSEXP, SEXP cutterSEXP){
  Rf_warning("_jiebaR_hmm_cut has been removed, please used _jiebaR_jiebaclass_hmm_cut");
  return R_NilValue;
}

SEXP _jiebaR_tag_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP userSEXP, SEXP stopSEXP){
  Rf_warning("_jiebaR_mix_ptr has been removed, please used _jiebaR_jiebaclass_ptr");
  return _jiebaR_jiebaclass_ptr(dictSEXP, modelSEXP, userSEXP, stopSEXP);
}

SEXP _jiebaR_tag_tag(SEXP xSEXP, SEXP cutterSEXP){
  Rf_warning("_jiebaR_tag_tag has been removed, please used _jiebaR_jiebaclass_tag_tag");
  return _jiebaR_jiebaclass_tag_tag(xSEXP, cutterSEXP);
}

SEXP _jiebaR_tag_file(SEXP xSEXP, SEXP cutterSEXP){
  Rf_warning("_jiebaR_tag_file has been removed, please used _jiebaR_jiebaclass_tag_file");
  return _jiebaR_jiebaclass_tag_file(xSEXP, cutterSEXP);
}

#define _RC(__FUN__, __NUMS__) { #__FUN__, (DL_FUNC) & __FUN__  , __NUMS__},




static const R_CallMethodDef callMethods[] = {
    { "_jiebaR_file_coding",  (DL_FUNC) &_jiebaR_file_coding    , 1 },
    { "_jiebaR_mp_ptr",      (DL_FUNC) &_jiebaR_mp_ptr        , 3 },
    { "_jiebaR_mp_cut",      (DL_FUNC) &_jiebaR_mp_cut        , 2 },
    { "_jiebaR_mix_ptr",     (DL_FUNC) &_jiebaR_mix_ptr       , 4 },
    { "_jiebaR_mix_cut",     (DL_FUNC) &_jiebaR_mix_cut       , 2 },
    { "_jiebaR_query_ptr",   (DL_FUNC) &_jiebaR_query_ptr     , 4 },
    { "_jiebaR_query_cut",   (DL_FUNC) &_jiebaR_query_cut     , 2 },
    { "_jiebaR_hmm_ptr",     (DL_FUNC) &_jiebaR_hmm_ptr       , 2 },
    { "_jiebaR_hmm_cut",     (DL_FUNC) &_jiebaR_hmm_cut       , 2 },
    { "_jiebaR_tag_ptr",     (DL_FUNC) &_jiebaR_tag_ptr       , 4 },
    { "_jiebaR_tag_tag",     (DL_FUNC) &_jiebaR_tag_tag       , 2 },
    { "_jiebaR_tag_file",    (DL_FUNC) &_jiebaR_tag_file      , 2 },
    { "_jiebaR_key_ptr",     (DL_FUNC) &_jiebaR_key_ptr       , 6 },
    { "_jiebaR_key_tag",     (DL_FUNC) &_jiebaR_key_tag       , 2 },
    { "_jiebaR_key_cut",     (DL_FUNC) &_jiebaR_key_cut       , 2 },
    { "_jiebaR_key_keys",    (DL_FUNC) &_jiebaR_key_keys      , 2 },
    { "_jiebaR_sim_ptr",     (DL_FUNC) &_jiebaR_sim_ptr       , 5 },
    { "_jiebaR_sim_sim",     (DL_FUNC) &_jiebaR_sim_sim       , 3 },
    { "_jiebaR_sim_distance",(DL_FUNC) &_jiebaR_sim_distance  , 4 },
    { "_jiebaR_words_freq"  ,(DL_FUNC) &_jiebaR_words_freq    , 1 },  
    _RC(_jiebaR_jiebaclass_ptr, 4)
    _RC(_jiebaR_jiebaclass_ptr_v2, 5)
    _RC(_jiebaR_jiebaclass_mix_cut, 2)
    _RC(_jiebaR_jiebaclass_mp_cut, 3)
    _RC(_jiebaR_jiebaclass_hmm_cut ,2)
    _RC(_jiebaR_jiebaclass_full_cut, 2)
    _RC(_jiebaR_jiebaclass_query_cut, 2)
    _RC(_jiebaR_jiebaclass_tag_tag, 2)
    _RC(_jiebaR_jiebaclass_tag_file, 2)
    _RC(_jiebaR_jiebaclass_tag_vec, 2)
    _RC(_jiebaR_add_user_word, 3)
    _RC(_jiebaR_u64tobin, 1)
  


    { NULL, NULL, 0 }
};


#define _RJ(__FUN__) R_RegisterCCallable( "_jiebaR", #__FUN__, (DL_FUNC) & __FUN__ );

void R_init_jiebaR(DllInfo *info)
{
    R_registerRoutines(info,
                     NULL,
                     callMethods,
                     NULL,
                     NULL);

    R_useDynamicSymbols(info, TRUE);

  /* used by external packages linking to internal xts code from C */    
  // v4
  // // 
    _RJ(_jiebaR_jiebaclass_ptr)
    _RJ(_jiebaR_jiebaclass_ptr_v2)
    _RJ(_jiebaR_jiebaclass_mix_cut)
    _RJ(_jiebaR_jiebaclass_mp_cut)
    _RJ(_jiebaR_jiebaclass_hmm_cut)
    _RJ(_jiebaR_jiebaclass_full_cut)
    _RJ(_jiebaR_jiebaclass_query_cut)
    _RJ(_jiebaR_jiebaclass_tag_tag)
    _RJ(_jiebaR_jiebaclass_tag_file)
    _RJ(_jiebaR_jiebaclass_tag_vec)  
    _RJ(_jiebaR_add_user_word)
    _RJ(_jiebaR_u64tobin)
      
  // v3
  // 
    R_RegisterCCallable("jiebaR", "_jiebaR_file_coding",  (DL_FUNC) &_jiebaR_file_coding    );
    R_RegisterCCallable("jiebaR", "_jiebaR_mp_ptr",      (DL_FUNC) &_jiebaR_mp_ptr        );
    R_RegisterCCallable("jiebaR", "_jiebaR_mp_cut",      (DL_FUNC) &_jiebaR_mp_cut        );
    R_RegisterCCallable("jiebaR", "_jiebaR_mix_ptr",     (DL_FUNC) &_jiebaR_mix_ptr       );
    R_RegisterCCallable("jiebaR", "_jiebaR_mix_cut",     (DL_FUNC) &_jiebaR_mix_cut       );
    R_RegisterCCallable("jiebaR", "_jiebaR_query_ptr",   (DL_FUNC) &_jiebaR_query_ptr     );
    R_RegisterCCallable("jiebaR", "_jiebaR_query_cut",   (DL_FUNC) &_jiebaR_query_cut     );
    R_RegisterCCallable("jiebaR", "_jiebaR_hmm_ptr",     (DL_FUNC) &_jiebaR_hmm_ptr       );
    R_RegisterCCallable("jiebaR", "_jiebaR_hmm_cut",     (DL_FUNC) &_jiebaR_hmm_cut       );
    R_RegisterCCallable("jiebaR", "_jiebaR_tag_ptr",     (DL_FUNC) &_jiebaR_tag_ptr       );
    R_RegisterCCallable("jiebaR", "_jiebaR_tag_tag",     (DL_FUNC) &_jiebaR_tag_tag       );
    R_RegisterCCallable("jiebaR", "_jiebaR_tag_file",    (DL_FUNC) &_jiebaR_tag_file      );
    R_RegisterCCallable("jiebaR", "_jiebaR_key_ptr",     (DL_FUNC) &_jiebaR_key_ptr       );
    R_RegisterCCallable("jiebaR", "_jiebaR_key_tag",     (DL_FUNC) &_jiebaR_key_tag       );
    R_RegisterCCallable("jiebaR", "_jiebaR_key_cut",     (DL_FUNC) &_jiebaR_key_cut       );
    R_RegisterCCallable("jiebaR", "_jiebaR_key_keys",    (DL_FUNC) &_jiebaR_key_keys      );
    R_RegisterCCallable("jiebaR", "_jiebaR_sim_ptr",     (DL_FUNC) &_jiebaR_sim_ptr       );
    R_RegisterCCallable("jiebaR", "_jiebaR_sim_sim",     (DL_FUNC) &_jiebaR_sim_sim       );
    R_RegisterCCallable("jiebaR", "_jiebaR_sim_distance",(DL_FUNC) &_jiebaR_sim_distance  );
    R_RegisterCCallable("jiebaR", "_jiebaR_words_freq",  (DL_FUNC) &_jiebaR_words_freq    );

}


