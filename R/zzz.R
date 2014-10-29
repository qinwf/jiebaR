##' @useDynLib jiebaR
##' @import Rcpp
##' @import methods
NULL 



.onLoad <- function(libname, pkgname) {
    if (.Platform$OS.type == "windows") {
      Sys.setlocale( locale = "English")
    }

}
