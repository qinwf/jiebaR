##' @useDynLib jiebaR
##' @import Rcpp
##' @import methods
NULL 



.onLoad <- function(libname, pkgname) {
    if (.Platform$OS.type == "windows") {
      Sys.setlocale( locale = "English")
    }
#     ##Path
#     
#     DICTPATH<-file.path(find.package("jiebaR",lib.loc=.libPaths()),"dict","jieba.dict.utf8")
#     HMMPATH <-file.path(find.package("jiebaR",lib.loc=.libPaths()),"dict","hmm_model.utf8")
#     USERPATH<-file.path(find.package("jiebaR",lib.loc=.libPaths()),"dict","user.dict.utf8")
#     STOPPATH<-file.path(find.package("jiebaR",lib.loc=.libPaths()),"dict","stop_words.utf8")
#     IDFPATH <-file.path(find.package("jiebaR",lib.loc=.libPaths()),"dict","idf.utf8")
#     
}

setLoadAction(
  function(ns){ 
    assign("DICTPATH", file.path(find.package("jiebaR",lib.loc=.libPaths()),"dict","jieba.dict.utf8"), envir = ns)
    assign("HMMPATH", file.path(find.package("jiebaR",lib.loc=.libPaths()),"dict","hmm_model.utf8"), envir = ns)
    assign("USERPATH", file.path(find.package("jiebaR",lib.loc=.libPaths()),"dict","user.dict.utf8"), envir = ns)
    assign("STOPPATH", file.path(find.package("jiebaR",lib.loc=.libPaths()),"dict","stop_words.utf8"), envir = ns)
    assign("IDFPATH", file.path(find.package("jiebaR",lib.loc=.libPaths()),"dict","idf.utf8"), envir = ns)
    
    })
