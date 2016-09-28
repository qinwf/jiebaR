#' generate IDF dict
#' 
#' Generate IDF dict from a list of documents. 
#' 
#' Input list contains multiple character vectors with words, 
#' and each vector represents a document.
#' 
#' Stop words will be removed from the result.
#' 
#' If path is not NULL, it will write the result to the path.
#'  
#' @param x a list of character
#' @param stop_word stopword path
#' @param path output path
#' @examples 
#' get_idf(list(c("abc","def"),c("abc"," ")))
#' @return a data.frame or a file
#' @seealso https://en.wikipedia.org/wiki/Tf-idf#Inverse_document_frequency_2
#' @export
get_idf = function(x,stop_word=STOPPATH,path=NULL){
  stopifnot(class(x)=="list")
  if(.Platform$OS.type=="windows"){
    x = lapply(x,enc2utf8)
  }
  df = get_idf_cpp(x,stop_word)
  # df = data.frame(name = names(res),count = log(length(x) / unlist(res,use.names = F) +1),stringsAsFactors = F)
  
  if(is.null(path)) {
    if(.Platform$OS.type == "windows"){
      Encoding(df$name) = "UTF-8"
    }
    return(df)
  }
  write.table(df,file = path,sep = " ",row.names = FALSE,col.names = FALSE,quote=FALSE)
  return(invisible(path))
}