#include <Rdefines.h>
#include <R_ext/Rdynload.h>

SEXP jiebaR_filecoding(SEXP fileSEXP);

SEXP jiebaR_mp_ptr(SEXP dictSEXP, SEXP userSEXP, SEXP stopSEXP); 

SEXP jiebaR_mp_cut(SEXP xSEXP, SEXP cutterSEXP);

SEXP jiebaR_mix_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP userSEXP, SEXP stopSEXP);

SEXP jiebaR_mix_cut(SEXP xSEXP, SEXP cutterSEXP);

SEXP jiebaR_query_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP nSEXP, SEXP stopSEXP);

SEXP jiebaR_query_cut(SEXP xSEXP, SEXP cutterSEXP);

SEXP jiebaR_hmm_ptr(SEXP modelSEXP, SEXP stopSEXP);

SEXP jiebaR_hmm_cut(SEXP xSEXP, SEXP cutterSEXP);

SEXP jiebaR_tag_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP userSEXP, SEXP stopSEXP);

SEXP jiebaR_tag_tag(SEXP xSEXP, SEXP cutterSEXP);

SEXP jiebaR_tag_file(SEXP xSEXP, SEXP cutterSEXP);

SEXP jiebaR_key_ptr(SEXP nSEXP, SEXP dictSEXP, SEXP modelSEXP, SEXP idfSEXP, SEXP stopSEXP);

SEXP jiebaR_key_tag(SEXP xSEXP, SEXP cutterSEXP);

SEXP jiebaR_key_cut(SEXP xSEXP, SEXP cutterSEXP);

SEXP jiebaR_key_keys(SEXP xSEXP, SEXP cutterSEXP);

SEXP jiebaR_sim_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP idfSEXP, SEXP stopSEXP);

SEXP jiebaR_sim_sim(SEXP codeSEXP, SEXP topnSEXP, SEXP cutterSEXP);

SEXP jiebaR_sim_distance(SEXP lhsSEXP, SEXP rhsSEXP, SEXP topnSEXP, SEXP cutterSEXP);

SEXP jiebaR_words_freq(SEXP x);

static R_CallMethodDef callMethods[] = {
    { "jiebaR_filecoding",  (DL_FUNC) &jiebaR_filecoding    , 1 },
    { "jiebaR_mp_ptr",      (DL_FUNC) &jiebaR_mp_ptr        , 3 },
    { "jiebaR_mp_cut",      (DL_FUNC) &jiebaR_mp_cut        , 2 },
    { "jiebaR_mix_ptr",     (DL_FUNC) &jiebaR_mix_ptr       , 4 },
    { "jiebaR_mix_cut",     (DL_FUNC) &jiebaR_mix_cut       , 2 },
    { "jiebaR_query_ptr",   (DL_FUNC) &jiebaR_query_ptr     , 4 },
    { "jiebaR_query_cut",   (DL_FUNC) &jiebaR_query_cut     , 2 },
    { "jiebaR_hmm_ptr",     (DL_FUNC) &jiebaR_hmm_ptr       , 2 },
    { "jiebaR_hmm_cut",     (DL_FUNC) &jiebaR_hmm_cut       , 2 },
    { "jiebaR_tag_ptr",     (DL_FUNC) &jiebaR_tag_ptr       , 4 },
    { "jiebaR_tag_tag",     (DL_FUNC) &jiebaR_tag_tag       , 2 },
    { "jiebaR_tag_file",    (DL_FUNC) &jiebaR_tag_file      , 2 },
    { "jiebaR_key_ptr",     (DL_FUNC) &jiebaR_key_ptr       , 5 },
    { "jiebaR_key_tag",     (DL_FUNC) &jiebaR_key_tag       , 2 },
    { "jiebaR_key_cut",     (DL_FUNC) &jiebaR_key_cut       , 2 },
    { "jiebaR_key_keys",    (DL_FUNC) &jiebaR_key_keys      , 2 },
    { "jiebaR_sim_ptr",     (DL_FUNC) &jiebaR_sim_ptr       , 4 },
    { "jiebaR_sim_sim",     (DL_FUNC) &jiebaR_sim_sim       , 3 },
    { "jiebaR_sim_distance",(DL_FUNC) &jiebaR_sim_distance  , 4 },
    { "jiebaR_words_freq"  ,(DL_FUNC) &jiebaR_words_freq    , 1 },  
    { NULL, NULL, 0 }
};

void R_init_jiebaR(DllInfo *info) {
  
    R_registerRoutines(info,
                       NULL,            /* slot for .C */
                       callMethods,     /* slot for .Call */
                       NULL,            /* slot for .Fortran */
                       NULL);           /* slot for .External */
    
    R_useDynamicSymbols(info, TRUE);
    
    R_RegisterCCallable("jiebaR", "jiebaR_filecoding",  (DL_FUNC) &jiebaR_filecoding    );
    R_RegisterCCallable("jiebaR", "jiebaR_mp_ptr",      (DL_FUNC) &jiebaR_mp_ptr        );
    R_RegisterCCallable("jiebaR", "jiebaR_mp_cut",      (DL_FUNC) &jiebaR_mp_cut        );
    R_RegisterCCallable("jiebaR", "jiebaR_mix_ptr",     (DL_FUNC) &jiebaR_mix_ptr       );
    R_RegisterCCallable("jiebaR", "jiebaR_mix_cut",     (DL_FUNC) &jiebaR_mix_cut       );
    R_RegisterCCallable("jiebaR", "jiebaR_query_ptr",   (DL_FUNC) &jiebaR_query_ptr     );
    R_RegisterCCallable("jiebaR", "jiebaR_query_cut",   (DL_FUNC) &jiebaR_query_cut     );
    R_RegisterCCallable("jiebaR", "jiebaR_hmm_ptr",     (DL_FUNC) &jiebaR_hmm_ptr       );
    R_RegisterCCallable("jiebaR", "jiebaR_hmm_cut",     (DL_FUNC) &jiebaR_hmm_cut       );
    R_RegisterCCallable("jiebaR", "jiebaR_tag_ptr",     (DL_FUNC) &jiebaR_tag_ptr       );
    R_RegisterCCallable("jiebaR", "jiebaR_tag_tag",     (DL_FUNC) &jiebaR_tag_tag       );
    R_RegisterCCallable("jiebaR", "jiebaR_tag_file",    (DL_FUNC) &jiebaR_tag_file      );
    R_RegisterCCallable("jiebaR", "jiebaR_key_ptr",     (DL_FUNC) &jiebaR_key_ptr       );
    R_RegisterCCallable("jiebaR", "jiebaR_key_tag",     (DL_FUNC) &jiebaR_key_tag       );
    R_RegisterCCallable("jiebaR", "jiebaR_key_cut",     (DL_FUNC) &jiebaR_key_cut       );
    R_RegisterCCallable("jiebaR", "jiebaR_key_keys",    (DL_FUNC) &jiebaR_key_keys      );
    R_RegisterCCallable("jiebaR", "jiebaR_sim_ptr",     (DL_FUNC) &jiebaR_sim_ptr       );
    R_RegisterCCallable("jiebaR", "jiebaR_sim_sim",     (DL_FUNC) &jiebaR_sim_sim       );
    R_RegisterCCallable("jiebaR", "jiebaR_sim_distance",(DL_FUNC) &jiebaR_sim_distance  );
    R_RegisterCCallable("jiebaR", "jiebaR_words_freq",  (DL_FUNC) &jiebaR_words_freq    );

}
