
.onLoad <- function(libname, pkgname) {
  if(.Platform$OS.type=="windows"){
    Sys.setlocale(locale="English")}
  loadModule("mod_mpseg", TRUE)
  loadModule("mod_mixseg", TRUE)
  loadModule("mod_query", TRUE)
  loadModule("mod_hmmseg", TRUE)
  loadModule("mod_tag", TRUE)
  loadModule("mod_key", TRUE)
  loadModule("mod_sim", TRUE)
}

