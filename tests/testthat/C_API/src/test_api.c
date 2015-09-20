#include "jiebaRAPI.h"

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
