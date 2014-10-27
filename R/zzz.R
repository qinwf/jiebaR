
.onLoad <- function(libname, pkgname) {
  if(.Platform$OS.type=="windows"){
    Sys.setlocale(locale="English")}
  loadModule("mod_mpseg", TRUE)
  loadModule("mod_mixseg", TRUE)
}
