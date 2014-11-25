#' @export
`<=.qseg`<-function(qseg, code){
  if(!exists("quick_worker",envir = .GlobalEnv )){
    if(exists("qseg",envir = .GlobalEnv,inherits = FALSE )) rm("qseg",envir = .GlobalEnv)
    modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
    quickparam = readRDS(modelpath)
    
    if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
    if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
    if(quickparam$user == "AUTO") quickparam$user = USERPATH
    if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
    if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
    
    assign("quick_worker",worker(
      type = quickparam$type, dict= quickparam$dict,hmm=quickparam$hmm, 
      user = quickparam$user, idf = quickparam$idf, stop_word = quickparam$stop_word, 
      write = quickparam$write, qmax = quickparam$qmax, topn = quickparam$topn, 
      encoding = quickparam$encoding, detect = quickparam$detect ,
      symbol = quickparam$symbol, lines = quickparam$lines, output = quickparam$output
    ) ,envir = .GlobalEnv )
    setactive()
  }
  if(file.exists(code) && quick_worker$write == T) {
    segment(code,quick_worker)
    xx<-NA
    class(xx) = "inv"
    return(xx)
  }
  else return(segment(code, quick_worker))
  
}


#' @export
qseg = new.env()

class(qseg) = "qseg"
setactive<-function(){
  
  assign("qseg",  new.env(parent = emptyenv()),envir = .GlobalEnv)
  class(.GlobalEnv$qseg) = "qseg"
  qtype <- function(v) {
    if (missing(v))
      switch(class(.GlobalEnv$quick_worker)[3],
             mixseg = "mix",
             hmmseg = "hmm",
             queryseg = "query",
             mpseg = "mp",
             simhash = "simhash",
             keywords = "keywords",
             tagger = "tag"
      )
    else {
      if(!any(v == c("mix","mp","hmm","query","simhash","keywords","tag"))){
        stop("Unkown worker type")
      }
      modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$type = v
      saveRDS(quickparam,modelpath)
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      assign("quick_worker",worker(
        type = quickparam$type, dict= quickparam$dict,hmm=quickparam$hmm, 
        user = quickparam$user, idf = quickparam$idf, stop_word = quickparam$stop_word, 
        write = quickparam$write, qmax = quickparam$qmax, topn = quickparam$topn, 
        encoding = quickparam$encoding, detect = quickparam$detect ,
        symbol = quickparam$symbol, lines = quickparam$lines, output = quickparam$output
      ) ,envir = .GlobalEnv )
      cat("Reset default quick worker type, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("type", qtype, .GlobalEnv$qseg)
  
  qdict <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$PrivateVarible
    else {
      
      modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$dict = v
      saveRDS(quickparam,modelpath)
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      assign("quick_worker",worker(
        type = quickparam$type, dict= quickparam$dict,hmm=quickparam$hmm, 
        user = quickparam$user, idf = quickparam$idf, stop_word = quickparam$stop_word, 
        write = quickparam$write, qmax = quickparam$qmax, topn = quickparam$topn, 
        encoding = quickparam$encoding, detect = quickparam$detect ,
        symbol = quickparam$symbol, lines = quickparam$lines, output = quickparam$output
      ) ,envir = .GlobalEnv )
      cat("Reset default dict path, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("dict", qdict, .GlobalEnv$qseg)
  
  qhmm <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$PrivateVarible
    else {
      modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$hmm = v
      saveRDS(quickparam,modelpath)
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      assign("quick_worker",worker(
        type = quickparam$type, dict= quickparam$dict,hmm=quickparam$hmm, 
        user = quickparam$user, idf = quickparam$idf, stop_word = quickparam$stop_word, 
        write = quickparam$write, qmax = quickparam$qmax, topn = quickparam$topn, 
        encoding = quickparam$encoding, detect = quickparam$detect ,
        symbol = quickparam$symbol, lines = quickparam$lines, output = quickparam$output
      ) ,envir = .GlobalEnv )
      cat("Reset default hmm path, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("hmm", qhmm, .GlobalEnv$qseg)
  
  qstop_word <-function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$PrivateVarible
    else {
      modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$stop_word = v
      saveRDS(quickparam,modelpath)
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      assign("quick_worker",worker(
        type = quickparam$type, dict= quickparam$dict,hmm=quickparam$hmm, 
        user = quickparam$user, idf = quickparam$idf, stop_word = quickparam$stop_word, 
        write = quickparam$write, qmax = quickparam$qmax, topn = quickparam$topn, 
        encoding = quickparam$encoding, detect = quickparam$detect ,
        symbol = quickparam$symbol, lines = quickparam$lines, output = quickparam$output
      ) ,envir = .GlobalEnv )
      cat("Reset default stop_word path, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("stop_word", qstop_word, .GlobalEnv$qseg)
  
  quser <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$PrivateVarible
    else {
      modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$user = v
      saveRDS(quickparam,modelpath)
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      assign("quick_worker",worker(
        type = quickparam$type, dict= quickparam$dict,hmm=quickparam$hmm, 
        user = quickparam$user, idf = quickparam$idf, stop_word = quickparam$stop_word, 
        write = quickparam$write, qmax = quickparam$qmax, topn = quickparam$topn, 
        encoding = quickparam$encoding, detect = quickparam$detect ,
        symbol = quickparam$symbol, lines = quickparam$lines, output = quickparam$output
      ) ,envir = .GlobalEnv )
      cat("Reset default user dict path, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("user", quser, .GlobalEnv$qseg)
  
  qidf <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$PrivateVarible
    else {
      modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$idf = v
      saveRDS(quickparam,modelpath)
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      assign("quick_worker",worker(
        type = quickparam$type, dict= quickparam$dict,hmm=quickparam$hmm, 
        user = quickparam$user, idf = quickparam$idf, stop_word = quickparam$stop_word, 
        write = quickparam$write, qmax = quickparam$qmax, topn = quickparam$topn, 
        encoding = quickparam$encoding, detect = quickparam$detect ,
        symbol = quickparam$symbol, lines = quickparam$lines, output = quickparam$output
      ) ,envir = .GlobalEnv )
      cat("Reset default idf path, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("idf", qidf, .GlobalEnv$qseg)
  
  qqmax <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker
    else {
      modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$qmax = v
      saveRDS(quickparam,modelpath)
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      assign("quick_worker",worker(
        type = quickparam$type, dict= quickparam$dict,hmm=quickparam$hmm, 
        user = quickparam$user, idf = quickparam$idf, stop_word = quickparam$stop_word, 
        write = quickparam$write, qmax = quickparam$qmax, topn = quickparam$topn, 
        encoding = quickparam$encoding, detect = quickparam$detect ,
        symbol = quickparam$symbol, lines = quickparam$lines, output = quickparam$output
      ) ,envir = .GlobalEnv )
      cat("Reset default qmax, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("qmax", qqmax, .GlobalEnv$qseg)
  
  qtopn <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker
    else {
      modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$topn = v
      saveRDS(quickparam,modelpath)
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      assign("quick_worker",worker(
        type = quickparam$type, dict= quickparam$dict,hmm=quickparam$hmm, 
        user = quickparam$user, idf = quickparam$idf, stop_word = quickparam$stop_word, 
        write = quickparam$write, qmax = quickparam$qmax, topn = quickparam$topn, 
        encoding = quickparam$encoding, detect = quickparam$detect ,
        symbol = quickparam$symbol, lines = quickparam$lines, output = quickparam$output
      ) ,envir = .GlobalEnv )
      cat("Reset default topn, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("topn", qtopn, .GlobalEnv$qseg)
  
  qwrite <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$write
    else {
      stopifnot(is.logical(v))
      modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$write = v
      saveRDS(quickparam,modelpath)
      .GlobalEnv$quick_worker$write = v
      cat("Reset default topn, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("write", qwrite, .GlobalEnv$qseg)
  
  qdetect <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$detect
    else {
      stopifnot(is.logical(v))
      modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$detect = v
      saveRDS(quickparam,modelpath)
      .GlobalEnv$quick_worker$detect = v
      cat("new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("detect", qdetect, .GlobalEnv$qseg)
  
  qencoding <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$encoding
    else {
      modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$detect = v
      saveRDS(quickparam,modelpath)
      .GlobalEnv$quick_worker$encoding = v
      cat("new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("encoding", qencoding, .GlobalEnv$qseg)
  
  qsymbol <-function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$symbol
    else {
      stopifnot(is.logical(v))
      modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$symbol = v
      saveRDS(quickparam,modelpath)
      .GlobalEnv$quick_worker$symbol = v
      cat("new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("symbol", qsymbol, .GlobalEnv$qseg)
  
  qlines <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$lines
    else {
      stopifnot(is.numeric(v))
      modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$symbol = v
      saveRDS(quickparam,modelpath)
      .GlobalEnv$quick_worker$lines = v
      cat("new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("lines", qlines, .GlobalEnv$qseg)
  
  qoutput <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$output
    else {
      modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$symbol = v
      saveRDS(quickparam,modelpath)
      .GlobalEnv$quick_worker$lines = v
      cat("new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("output", qoutput, .GlobalEnv$qseg)
  
}

#' @export
get_qsegmodel<-function(){
  modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
  readRDS(modelpath)
}

#' @export
set_qsegmodel<-function(qsegmodel){
  testenv <- list2env(qsegmodel,parent =emptyenv())
  stopifnot(
    exists("type",envir = testenv),
    exists("dict",envir = testenv),
    exists("user",envir = testenv),
    exists("hmm",envir = testenv),
    exists("idf",envir = testenv),
    exists("stop_word",envir = testenv),
    exists("write",envir = testenv),
    exists("qmax",envir = testenv),
    exists("topn",envir = testenv),
    exists("encoding",envir = testenv),
    exists("detect",envir = testenv),
    exists("symbol",envir = testenv),
    exists("lines",envir = testenv),
    exists("output",envir = testenv)
  )
  modelpath  = file.path(find.package("jiebaR"),"dict","model.rda")
  saveRDS(qsegmodel,modelpath)
}

#' @export
reset_qsegmodel<-function(){
  file.copy(file.path(find.package("jiebaR"),"dict","backup.rda"),
            file.path(find.package("jiebaR"),"dict","model.rda"),
            overwrite = T)
}