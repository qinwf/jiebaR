##' @useDynLib jiebaR
##' @import Rcpp
##' @import jiebaRD
##' @importFrom utils file.edit unzip write.table
NULL

#' The path of dictionary
#' 
#' The path of dictionary, and it is used by segmentation and other 
#' function. 
#' @format  character
#' @export
DICTPATH<-NULL

#' @rdname DICTPATH
#' @export
HMMPATH<-NULL

#' @rdname DICTPATH
#' @export
USERPATH<-NULL

#' @rdname DICTPATH
#' @export
IDFPATH<-NULL

#' @rdname DICTPATH
#' @export
STOPPATH<-NULL

TIMESTAMP<-NULL

.onLoad <- function(libname, pkgname) {
#     if (.Platform$OS.type == "windows") {
#       Sys.setlocale( locale = "English")
#     }
  
    assign(x = "TIMESTAMP",  as.numeric(Sys.time()),asNamespace('jiebaR'))
  
    assign(x = "DICTPATH", file.path(find.package("jiebaRD"),"dict","jieba.dict.utf8"),asNamespace('jiebaR'))
    assign(x = "HMMPATH",  file.path(find.package("jiebaRD"),"dict","hmm_model.utf8"),asNamespace('jiebaR'))
    assign(x = "USERPATH", file.path(find.package("jiebaRD"),"dict","user.dict.utf8"),asNamespace('jiebaR'))
    assign(x = "STOPPATH", file.path(find.package("jiebaRD"),"dict","stop_words.utf8"),asNamespace('jiebaR'))
    assign(x = "IDFPATH",  file.path(find.package("jiebaRD"),"dict","idf.utf8"),asNamespace('jiebaR'))

}

# setLoadAction(
#   function(ns){ 
# #     loadModule("mod_mpseg", TRUE)
# #     loadModule("mod_mixseg", TRUE)
# #     loadModule("mod_query", TRUE)
# #     loadModule("mod_hmmseg", TRUE)
# #     loadModule("mod_tag", TRUE)
# #     loadModule("mod_key", TRUE)
# #     loadModule("mod_sim", TRUE)
#     ###Loading DICTPATH when package loaded.    
#    })

.onDetach<- function(libpath) {
  #     if (.Platform$OS.type == "windows") {
  #       Sys.setlocale( locale = "English")
  #     }
  if(exists("quick_worker",envir = .GlobalEnv,,inherits = FALSE )) rm("quick_worker",envir = .GlobalEnv)
  if(exists("qseg",envir = .GlobalEnv,,inherits = FALSE )) rm("qseg",envir = .GlobalEnv)
  
}
