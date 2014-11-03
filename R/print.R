#' Print worker settings
#' 
#' The functoin print the worker settings.
#' 
#' @param x The jiebaR Worker.
#' @author Qin Wenfeng <\url{http://qinwenfeng.com}>
#' @export
print.hmmseg<-function(x,...){
  cat("Worker Type:  Hidden Markov Model Segment\n"); cat("\n")
  cat("Detect Encoding :  "); cat(jiebar$detect);cat("\n")
  cat("Default Encoding:  "); cat(jiebar$encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(jiebar$symbol);cat("\n")
  cat("Output Path     :  ");cat(jiebar$output);cat("\n")
  cat("Write File      :  ");cat(jiebar$write);cat("\n")
  cat("Max Read Lines  :  ");cat(jiebar$lines);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(jiebar$PrivateVarible)
}

#' @rdname print.hmmseg
#' @export
print.queryseg<-function(x,...){
  cat("Worker Type:  Query Segment\n"); cat("\n")
  cat("Detect Encoding :  "); cat(jiebar$detect);cat("\n")
  cat("Default Encoding:  "); cat(jiebar$encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(jiebar$symbol);cat("\n")
  cat("Output Path     :  ");cat(jiebar$output);cat("\n")
  cat("Write File      :  ");cat(jiebar$write);cat("\n")
  cat("Max Read Lines  :  ");cat(jiebar$lines);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(jiebar$PrivateVarible)
}

#' @rdname print.hmmseg
#' @export
print.simhash<-function(x,...){
  cat("Worker Type:  Simhash\n"); cat("\n")
  cat("Detect Encoding :  "); cat(jiebar$detect);cat("\n")
  cat("Default Encoding:  "); cat(jiebar$encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(jiebar$symbol);cat("\n")
  cat("Keywords Numbers:  ");cat(jiebar$topn);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(jiebar$PrivateVarible)
}

#' @rdname print.hmmseg
#' @export
print.keywords<-function(x,...){
  cat("Worker Type:  Keyword Extraction\n"); cat("\n")
  cat("Detect Encoding :  "); cat(jiebar$detect);cat("\n")
  cat("Default Encoding:  "); cat(jiebar$encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(jiebar$symbol);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(jiebar$PrivateVarible)
}

#' @rdname print.hmmseg
#' @export
print.tagger<-function(x,...){
  cat("Worker Type:  Speech Tagging\n"); cat("\n")
  cat("Detect Encoding :  "); cat(jiebar$detect);cat("\n")
  cat("Default Encoding:  "); cat(jiebar$encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(jiebar$symbol);cat("\n")
  cat("Output Path     :  ");cat(jiebar$output);cat("\n")
  cat("Write File      :  ");cat(jiebar$write);cat("\n")
  cat("Max Read Lines  :  ");cat(jiebar$lines);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(jiebar$PrivateVarible)
}

#' @rdname print.hmmseg
#' @export
print.mixseg<-function(x,...){
  cat("Worker Type:  Mix Segment\n"); cat("\n")
  cat("Detect Encoding :  "); cat(jiebar$detect);cat("\n")
  cat("Default Encoding:  "); cat(jiebar$encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(jiebar$symbol);cat("\n")
  cat("Output Path     :  ");cat(jiebar$output);cat("\n")
  cat("Write File      :  ");cat(jiebar$write);cat("\n")
  cat("Max Read Lines  :  ");cat(jiebar$lines);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(jiebar$PrivateVarible)
}

#' @rdname print.hmmseg
#' @export
print.mpseg<-function(x,...){
  cat("Worker Type:  Maximum Probability Segment\n"); cat("\n")
  cat("Detect Encoding :  "); cat(jiebar$detect);cat("\n")
  cat("Default Encoding:  "); cat(jiebar$encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(jiebar$symbol);cat("\n")
  cat("Output Path     :  ");cat(jiebar$output);cat("\n")
  cat("Write File      :  ");cat(jiebar$write);cat("\n")
  cat("Max Read Lines  :  ");cat(jiebar$lines);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(jiebar$PrivateVarible)
}