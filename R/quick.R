#' Quick mode symbol
#' 
#' Quick mode symbol to do segmentation, keyword extraction 
#' and speech tagging. This symbol will initialize a \code{quick_worker} 
#' when it is first called, and will do segmentation or other types of work 
#' immediately. 
#' 
#' You can reset the default model setting by \code{$}, and 
#' it will change the default setting the next time you use quick mode. 
#' If you only want to change the parameter temporarily, you can reset the 
#' settings of \code{quick_worker$}. \code{\link{get_qsegmodel}}, 
#' \code{\link{set_qsegmodel}}, and \code{\link{reset_qsegmodel}}
#' are also available for setting quick mode settings.
#' 
#' @format qseg an environment
#' @examples 
#' \dontrun{
#' qseg <= "This is test"
#' qseg <= "This is the second test"
#' }
#' 
#' \dontrun{
#' qseg <= "This is test"
#' qseg$detect = T
#' qseg
#' get_qsegmodel()
#' }
#' 
#' @param qseg a qseg object
#' @param code a string
#' 
#' @seealso \code{\link{set_qsegmodel}} \code{\link{worker}} 
#' @author Qin Wenfeng <\url{http://qinwenfeng.com}>
#' @export
`<=.qseg`<-function(qseg, code){
  if(!exists("quick_worker",envir = .GlobalEnv ,inherits = F) || 
       .GlobalEnv$quick_worker$PrivateVarible$timestamp != TIMESTAMP){
    
    if(exists("qseg",envir = .GlobalEnv,inherits = FALSE ) ) 
      rm("qseg",envir = .GlobalEnv)
    
    modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
    quickparam = readRDS(modelpath)
    
    if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
    if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
    if(quickparam$user == "AUTO") quickparam$user = USERPATH
    if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
    if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
    
    createquickworker(quickparam)
    setactive()
  } 
  if("segment" %in% class(.GlobalEnv$quick_worker)){
    
    if(file.exists(code) && .GlobalEnv$quick_worker$write == T) {
      segment(code,.GlobalEnv$quick_worker)
      xx<-NA
      class(xx) = "inv"
      return(xx)
    } else return(segment(code, .GlobalEnv$quick_worker))
    
  } else if("tagger" %in% class(.GlobalEnv$quick_worker)){
    
    tagging(code,.GlobalEnv$quick_worker)
    
  } else if("keywords" %in% class(.GlobalEnv$quick_worker)){
    
    keywords(code,.GlobalEnv$quick_worker)
    
  } else if("simhash" %in% class(.GlobalEnv$quick_worker)){
    
    simhash(code,.GlobalEnv$quick_worker)
    
  }
}

#' @rdname less-than-equals-.qseg
#' @export
`[.qseg`<- `<=.qseg`

#' @rdname less-than-equals-.qseg
#' @export
qseg = new.env()

class(qseg) = "qseg"

setactive<-function(){
  
  .GlobalEnv$qseg<-new.env(parent = emptyenv())
  
  class(.GlobalEnv$qseg) = "qseg"
  
  qtype <- function(v) {
    if (missing(v)) {
      switch(class(.GlobalEnv$quick_worker)[3],
             mixseg = "mix",
             hmmseg = "hmm",
             queryseg = "query",
             mpseg = "mp",
             simhash = "simhash",
             keywords = "keywords",
             tagger = "tag"
      )} else {

        if(!any(v == c("mix","mp","hmm","query","simhash","keywords","tag"))){
          stop("Unknown worker type")
        }
        
        modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
        quickparam = readRDS(modelpath)
        quickparam$type = v[1]
        try(saveRDS(quickparam,modelpath))
        
        if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
        if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
        if(quickparam$user == "AUTO") quickparam$user = USERPATH
        if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
        if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
        
        createquickworker(quickparam)
        cat("Reset default quick worker type, new worker:\n")
        print(.GlobalEnv$quick_worker)
      }
    
  }
  
  makeActiveBinding("type", qtype, .GlobalEnv$qseg)
  
  qdict <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$PrivateVarible
    else {
      stopifnot(is.character(v))
      modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$dict = v[1]
      try(saveRDS(quickparam,modelpath))
      
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      
      createquickworker(quickparam)
      cat("Reset default dict path, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("dict", qdict, .GlobalEnv$qseg)
  
  qhmm <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$PrivateVarible
    else {
      stopifnot(is.character(v))
      modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$hmm = v[1]
      try(saveRDS(quickparam,modelpath))
      
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      
      createquickworker(quickparam)
      cat("Reset default hmm path, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("hmm", qhmm, .GlobalEnv$qseg)
  
  qstop_word <-function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$PrivateVarible
    else {
      stopifnot(is.character(v))
      modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$stop_word = v[1]
      try(saveRDS(quickparam,modelpath))
      
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      
      createquickworker(quickparam)
      cat("Reset default stop_word path, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("stop_word", qstop_word, .GlobalEnv$qseg)
  
  quser <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$PrivateVarible
    else {
      stopifnot(is.character(v))
      modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$user = v[1]
      try(saveRDS(quickparam,modelpath))
      
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      
      createquickworker(quickparam)
      cat("Reset default user dict path, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("user", quser, .GlobalEnv$qseg)
  
  qidf <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$PrivateVarible
    else {
      stopifnot(is.character(v))
      modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$idf = v[1]
      try(saveRDS(quickparam,modelpath))
      
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      
      createquickworker(quickparam)
      cat("Reset default idf path, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("idf", qidf, .GlobalEnv$qseg)
  
  qqmax <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker
    else {
      stopifnot(is.numeric(v))
      modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$qmax = v[1]
      try(saveRDS(quickparam,modelpath))
      
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      
      createquickworker(quickparam)
      cat("Reset default qmax, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("qmax", qqmax, .GlobalEnv$qseg)
  
  qtopn <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker
    else {
      stopifnot(is.numeric(v))
      modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$topn = v[1]
      try(saveRDS(quickparam,modelpath))
      
      if(quickparam$dict == "AUTO") quickparam$dict = DICTPATH
      if(quickparam$hmm == "AUTO") quickparam$hmm = HMMPATH
      if(quickparam$user == "AUTO") quickparam$user = USERPATH
      if(quickparam$stop_word == "AUTO") quickparam$stop_word = STOPPATH
      if(quickparam$idf == "AUTO") quickparam$idf = IDFPATH
      
      createquickworker(quickparam)
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
      modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$write = v[1]
      try(saveRDS(quickparam,modelpath))
      .GlobalEnv$quick_worker$write = v[1]
      cat("Reset default write, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("write", qwrite, .GlobalEnv$qseg)
  
  qdetect <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$detect
    else {
      stopifnot(is.logical(v))
      modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$detect = v[1]
      try(saveRDS(quickparam,modelpath))
      .GlobalEnv$quick_worker$detect = v[1]
      cat("Reset default detect, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("detect", qdetect, .GlobalEnv$qseg)
  
  qencoding <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$encoding
    else {
      stopifnot(is.character(v))
      modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
      
      quickparam = readRDS(modelpath)
      quickparam$encoding = v[1]
      try(saveRDS(quickparam,modelpath))
      
      .GlobalEnv$quick_worker$encoding = v[1]
      cat("Reset default encoding, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("encoding", qencoding, .GlobalEnv$qseg)
  
  qsymbol <-function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$symbol
    else {
      stopifnot(is.logical(v))
      
      modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$symbol = v[1]
      try(saveRDS(quickparam,modelpath))
      
      .GlobalEnv$quick_worker$symbol = v[1]
      cat("Reset default symbol, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("symbol", qsymbol, .GlobalEnv$qseg)

  qbylines <-function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$bylines
    else {
      stopifnot(is.logical(v))
      
      modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$bylines = v[1]
      try(saveRDS(quickparam,modelpath))
      
      .GlobalEnv$quick_worker$bylines = v[1]
      cat("Reset default symbol, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("bylines", qbylines, .GlobalEnv$qseg)  

  qlines <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$lines
    else {
      stopifnot(is.numeric(v))
      
      modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$lines = v[1]
      try(saveRDS(quickparam,modelpath))
      
      .GlobalEnv$quick_worker$lines = v[1]
      cat("Reset default lines, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("lines", qlines, .GlobalEnv$qseg)
  
  qoutput <- function(v) {
    if (missing(v))
      .GlobalEnv$quick_worker$output
    else {
      stopifnot(is.character(v)||is.null(v))
      
      modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
      quickparam = readRDS(modelpath)
      quickparam$output = v[1]
      try(saveRDS(quickparam,modelpath))
      
      .GlobalEnv$quick_worker$lines = v[1]
      cat("Reset default output, new worker:\n")
      print(.GlobalEnv$quick_worker)
    }
    
  }
  
  makeActiveBinding("output", qoutput, .GlobalEnv$qseg)
  
}

#' @rdname set_qsegmodel
#' @export
get_qsegmodel<-function(){
  modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
  readRDS(modelpath)
}

#' Set quick mode model
#' 
#' These function can get and modify quick mode model. \code{get_qsegmodel} returns
#' the default model parameters. \code{set_qsegmodel} can modify quick mode model 
#' using a list, which has the same structure as the return value of get_qsegmodel.
#' \code{reset_qsegmodel} can reset the default model to origin \code{jiebaR} default
#' model.
#' @param  qsegmodel a list which has the same structure as the return value of get_qsegmodel
#' @seealso \code{\link{qseg}} \code{\link{worker}} 
#' @author Qin Wenfeng <\url{http://qinwenfeng.com}>
#' @examples 
#' \dontrun{
#' qseg <= "This is test"
#' qseg <= "This is the second test"
#' }
#' 
#' \dontrun{
#' qseg <= "This is test"
#' qseg$detect = T
#' qseg
#' get_qsegmodel()
#' model = get_qsegmodel()
#' model$detect = F
#' set_qsegmodel(model)
#' reset_qsegmodel()
#' }
#' @export
set_qsegmodel<-function(qsegmodel){  
  stopifnot(
    names(qsegmodel)%in%c("type","dict","user","hmm","idf","write","stop_word",
                          "qmax","topn","encoding","detect","symbol","lines",
                          "output","bylines")
  )
  modelpath  = file.path(find.package("jiebaR"),"model","model.rda")
  try(saveRDS(qsegmodel,modelpath))
}

#' @rdname set_qsegmodel
#' @export
reset_qsegmodel<-function(){
  file.copy(file.path(find.package("jiebaR"),"model","backup.rda"),
            file.path(find.package("jiebaR"),"model","model.rda"),
            overwrite = T)
  invisible()
}

createquickworker<-function(quickparam){
  
  .GlobalEnv$quick_worker <- worker(
    type  = quickparam$type, 
    dict  = quickparam$dict,
    hmm   = quickparam$hmm, 
    user  = quickparam$user, 
    idf   = quickparam$idf, 
    stop_word = quickparam$stop_word, 
    write = quickparam$write, 
    qmax  = quickparam$qmax, 
    topn  = quickparam$topn, 
    encoding = quickparam$encoding, 
    detect   = quickparam$detect ,
    symbol   = quickparam$symbol, 
    lines    = quickparam$lines, 
    output   = quickparam$output,
    bylines  = quickparam$bylines
  ) 
}