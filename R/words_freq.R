#' @title The frequency of words
#' @description The function return the frequency of words
#' @param x a vector of words
#' @return The frequency of words
#' @author Qin wenfeng
#' @export
freq <- function(x){
  if("character" %in% class(x) != TRUE){
    stop("Please give me a character vector.")
  }
  res = jiebaR:::words_freq(x)
  s = data.frame(char=attr(res,"names"),freq=as.numeric(res),stringsAsFactors = F)
  if(.Platform$OS.type=="windows"){
    Encoding(s$char) = "UTF-8"
  }
  return(s)
}