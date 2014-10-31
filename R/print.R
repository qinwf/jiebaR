#' @export
print.hmmseg<-function(jiebar){
  cat("Worker Type:  Hidden Markov Model Segment\n"); cat("\n")
  cat("Detect Encoding :  "); cat(jiebar$DetectEncoding);cat("\n")
  cat("Default Encoding:  "); cat(jiebar$Encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(jiebar$Symbol);cat("\n")
  cat("Write File      :  ");cat(jiebar$WriteFile);cat("\n")
  cat("Max Read Lines  :  ");cat(jiebar$ReadLines);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(jiebar$PrivateVarible)
}

#' @export
print.queryseg<-function(jiebar){
  cat("Worker Type:  Query Segment\n"); cat("\n")
  cat("Detect Encoding :  "); cat(jiebar$DetectEncoding);cat("\n")
  cat("Default Encoding:  "); cat(jiebar$Encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(jiebar$Symbol);cat("\n")
  cat("Write File      :  ");cat(jiebar$WriteFile);cat("\n")
  cat("Max Read Lines  :  ");cat(jiebar$ReadLines);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(jiebar$PrivateVarible)
}

#' @export
print.simhash<-function(jiebar){
  cat("Worker Type:  Simhash\n"); cat("\n")
  cat("Detect Encoding :  "); cat(jiebar$DetectEncoding);cat("\n")
  cat("Default Encoding:  "); cat(jiebar$Encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(jiebar$Symbol);cat("\n")
  cat("Keywords Numbers:  ");cat(jiebar$Top_N_Words);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(jiebar$PrivateVarible)
}

#' @export
print.keywords<-function(jiebar){
  cat("Worker Type:  Keyword Extraction\n"); cat("\n")
  cat("Detect Encoding :  "); cat(jiebar$DetectEncoding);cat("\n")
  cat("Default Encoding:  "); cat(jiebar$Encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(jiebar$Symbol);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(jiebar$PrivateVarible)
}

#' @export
print.tagger<-function(jiebar){
  cat("Worker Type:  Speech Tagging\n"); cat("\n")
  cat("Detect Encoding :  "); cat(jiebar$DetectEncoding);cat("\n")
  cat("Default Encoding:  "); cat(jiebar$Encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(jiebar$Symbol);cat("\n")
  cat("Write File      :  ");cat(jiebar$WriteFile);cat("\n")
  cat("Max Read Lines  :  ");cat(jiebar$ReadLines);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(jiebar$PrivateVarible)
}

#' @export
print.mixseg<-function(jiebar){
  cat("Worker Type:  Mix Segment\n"); cat("\n")
  cat("Detect Encoding :  "); cat(jiebar$DetectEncoding);cat("\n")
  cat("Default Encoding:  "); cat(jiebar$Encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(jiebar$Symbol);cat("\n")
  cat("Write File      :  ");cat(jiebar$WriteFile);cat("\n")
  cat("Max Read Lines  :  ");cat(jiebar$ReadLines);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(jiebar$PrivateVarible)
}

#' @export
print.mpseg<-function(jiebar){
  cat("Worker Type:  Maximum Probability Segment\n"); cat("\n")
  cat("Detect Encoding :  "); cat(jiebar$DetectEncoding);cat("\n")
  cat("Default Encoding:  "); cat(jiebar$Encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(jiebar$Symbol);cat("\n")
  cat("Write File      :  ");cat(jiebar$WriteFile);cat("\n")
  cat("Max Read Lines  :  ");cat(jiebar$ReadLines);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(jiebar$PrivateVarible)
}