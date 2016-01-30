#' Print worker settings
#' 
#' These functoins print the worker settings.
#' 
#' @param x The jiebaR Worker.
#' @param ... Other arguments.
#' @author Qin Wenfeng 
#' @export
print.jieba<-function(x,...){
  cat("Worker Type:  Jieba Segment\n"); cat("\n")
  cat("Default Method  :  "); cat(x$default);cat("\n")
  cat("Detect Encoding :  "); cat(x$detect);cat("\n")
  cat("Default Encoding:  "); cat(x$encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(x$symbol);cat("\n")
  cat("Output Path     :  ");cat(x$output);cat("\n")
  cat("Write File      :  ");cat(x$write);cat("\n")
  cat("By Lines        :  ");cat(x$bylines);cat("\n")
  cat("Max Word Length :  ");cat(x$max_word_length);cat("\n")
  cat("Max Read Lines  :  ");cat(x$lines);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(x$PrivateVarible)
  cat("$default $detect $encoding $symbol $output $write $lines $bylines can be reset.\n")
}


#' @rdname print.jieba
#' @export
print.simhash<-function(x,...){
  cat("Worker Type:  Simhash\n"); cat("\n")
  cat("Detect Encoding :  "); cat(x$detect);cat("\n")
  cat("Default Encoding:  "); cat(x$encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(x$symbol);cat("\n")
  cat("Keywords Numbers:  ");cat(x$topn);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(x$PrivateVarible)
  cat("$detect $encoding $symbol $lines $topn can be reset.\n")
}

#' @rdname print.jieba
#' @export
print.keywords<-function(x,...){
  cat("Worker Type:  Keyword Extraction\n"); cat("\n")
  cat("Detect Encoding :  "); cat(x$detect);cat("\n")
  cat("Default Encoding:  "); cat(x$encoding);cat("\n")
  cat("Keep Symbols    :  ");cat(x$symbol);cat("\n");cat("\n")
  cat("Fixed Model Components:  ");cat("\n");cat("\n")
  print(x$PrivateVarible)
  cat("$detect $encoding $symbol can be reset.\n")
}

#' @rdname print.jieba
#' @export
print.qseg<-function(x,...){
  if(exists("quick_worker",envir = .GlobalEnv,inherits = F ))
     print(.GlobalEnv$quick_worker)
}

# #' @rdname print.hmmseg
# #' @export
# print.stopword_list<-function(x,...){
#   cat("[1] ")
#   cat(paste(head(x,n = 5),collapse = ", "))
#   cat(", ...\n")
# }