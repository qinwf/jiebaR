#ifndef __JIEBARAPI_H__
#define __JIEBARAPI_H__

#include <R.h>
#include <Rinternals.h>

#include <stddef.h>
#include <R_ext/Rdynload.h>

#ifdef HAVE_VISIBILITY_ATTRIBUTE
    # define attribute_hidden __attribute__ ((visibility ("hidden")))
#else
    # define attribute_hidden
#endif

#ifdef __cplusplus
extern "C" {
#endif

SEXP attribute_hidden jiebaR_filecoding(SEXP fileSEXP){
	static SEXP(*f)(SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP)) R_GetCCallable("jiebaR", "jiebaR_filecoding");
    }
    return f(fileSEXP);
};

SEXP attribute_hidden jiebaR_mp_ptr(SEXP dictSEXP, SEXP userSEXP){
	static SEXP(*f)(SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_mp_ptr");
    }
    return f(dictSEXP,userSEXP);
}; 

SEXP attribute_hidden jiebaR_mp_cut(SEXP xSEXP, SEXP cutterSEXP){
	static SEXP(*f)(SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_mp_cut");
    }
    return f(xSEXP,cutterSEXP);
};

SEXP attribute_hidden jiebaR_mix_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP userSEXP){
	static SEXP(*f)(SEXP,SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_mix_ptr");
    }
    return f(dictSEXP, modelSEXP, userSEXP);
};

SEXP attribute_hidden jiebaR_mix_cut(SEXP xSEXP, SEXP cutterSEXP){
	static SEXP(*f)(SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_mix_cut");
    }
    return f(xSEXP,cutterSEXP);
};

SEXP attribute_hidden jiebaR_query_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP nSEXP){
	static SEXP(*f)(SEXP,SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_query_ptr");
    }
    return f(dictSEXP, modelSEXP, nSEXP);
};

SEXP attribute_hidden jiebaR_query_cut(SEXP xSEXP, SEXP cutterSEXP){
	static SEXP(*f)(SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_query_cut");
    }
    return f(xSEXP,cutterSEXP);
};

SEXP attribute_hidden jiebaR_hmm_ptr(SEXP modelSEXP){
	static SEXP(*f)(SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP)) R_GetCCallable("jiebaR", "jiebaR_hmm_ptr");
    }
    return f(modelSEXP);
};

SEXP attribute_hidden jiebaR_hmm_cut(SEXP xSEXP, SEXP cutterSEXP){
	static SEXP(*f)(SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_hmm_cut");
    }
    return f(xSEXP,cutterSEXP);
};

SEXP attribute_hidden jiebaR_tag_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP userSEXP){
	static SEXP(*f)(SEXP,SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_tag_ptr");
    }
    return f(dictSEXP, modelSEXP, userSEXP);
};

SEXP attribute_hidden jiebaR_tag_tag(SEXP xSEXP, SEXP cutterSEXP){
	static SEXP(*f)(SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_tag_tag");
    }
    return f(xSEXP,cutterSEXP);
};
SEXP attribute_hidden jiebaR_tag_file(SEXP xSEXP, SEXP cutterSEXP){
	static SEXP(*f)(SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_tag_file");
    }
    return f(xSEXP,cutterSEXP);
};

SEXP attribute_hidden jiebaR_key_ptr(SEXP nSEXP, SEXP dictSEXP, SEXP modelSEXP, SEXP idfSEXP, SEXP stopSEXP){
	static SEXP(*f)(SEXP,SEXP,SEXP,SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP,SEXP,SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_key_ptr");
    }
    return f(nSEXP, dictSEXP, modelSEXP, idfSEXP, stopSEXP);
};

SEXP attribute_hidden jiebaR_key_tag(SEXP xSEXP, SEXP cutterSEXP){
	static SEXP(*f)(SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_key_tag");
    }
    return f(xSEXP,cutterSEXP);
};

SEXP attribute_hidden jiebaR_key_cut(SEXP xSEXP, SEXP cutterSEXP){
	static SEXP(*f)(SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_key_cut");
    }
    return f(xSEXP,cutterSEXP);
};

SEXP attribute_hidden jiebaR_key_keys(SEXP xSEXP, SEXP cutterSEXP){
	static SEXP(*f)(SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_key_keys");
    }
    return f(xSEXP,cutterSEXP);
};

SEXP attribute_hidden jiebaR_sim_ptr(SEXP dictSEXP, SEXP modelSEXP, SEXP idfSEXP, SEXP stopSEXP){
	static SEXP(*f)(SEXP,SEXP,SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP,SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_sim_ptr");
    }
    return f(dictSEXP, modelSEXP, idfSEXP, stopSEXP);
};

SEXP attribute_hidden jiebaR_sim_sim(SEXP codeSEXP, SEXP topnSEXP, SEXP cutterSEXP){
	static SEXP(*f)(SEXP,SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_sim_sim");
    }
    return f(codeSEXP, topnSEXP, cutterSEXP);
};

SEXP attribute_hidden jiebaR_sim_distance(SEXP lhsSEXP, SEXP rhsSEXP, SEXP topnSEXP, SEXP cutterSEXP){
	static SEXP(*f)(SEXP,SEXP,SEXP,SEXP) = NULL;
    if (!f) {
        f = (SEXP(*)(SEXP,SEXP,SEXP,SEXP)) R_GetCCallable("jiebaR", "jiebaR_sim_distance");
    }
    return f(lhsSEXP, rhsSEXP, topnSEXP, cutterSEXP);
};


#ifdef __cplusplus
}
#endif

#endif /* __JIEBARAPI_H__ */