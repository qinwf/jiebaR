quickmod = new.env(parent = emptyenv())

class(quickmod) = "quickmod"

`<=.quickmod`<-function(quickmod, code){
    if(!exists(quick_worker,envir = .GlobalEnv )){
    modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
    quickparam = readRDS(modelpath)
    
    if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
    if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
    if(quickparam$user == "AUTO") quickparam$user = USERPATH
    if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
    if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
    
    assign("quick_worker",worker(
      quickparam$type, quickparam$dict, quickparam$hmm, 
      quickparam$user, quickparam$idf, quickparam$stop_word, quickparam$write,
      quickparam$qmax, quickparam$topn, quickparam$encoding, quickparam$detect ,
      quickparam$symbol, quickparam$lines, quickparam$output
      ) ,envir = .GlobalEnv )
  }
  if(file.exists(code) && quick_worker$write == T) {
    segment(code,quick_worker)
    xx<-NA
    class(xx) = "inv"
    return(xx)
  }
  else return(segment(code, quick_worker))
  
  
}

# f <- local( {
#   x <- 1
#   function(v) {
#     if (missing(v))
#       cat("get\n")
#     else {
#       cat("set\n")
#       x <<- v
#     }
#     x
#   }
# })