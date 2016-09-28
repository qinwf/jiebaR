#' A package for Chinese text segmentation
#'
#' This is a package for Chinese text segmentation, keyword extraction 
#' and speech tagging with Rcpp and cppjieba.
#' 
#' You can use custom 
#' dictionary. JiebaR can 
#' also identify new words, but adding new words will ensure higher 
#' accuracy.
#' 
#' @docType package
#' @name jiebaR
#' @author Qin Wenfeng <\url{http://qinwenfeng.com}>
#' @references CppJieba \url{https://github.com/aszxqw/cppjieba};
#' @seealso JiebaR \url{https://github.com/qinwf/jiebaR};
#' @examples 
#' ### Note: Can not display Chinese characters here.
#' \dontrun{
#' words = "hello world"
#' engine1 = worker()
#' segment(words, engine1)
#'
#' # "./temp.txt" is a file path
#' 
#' segment("./temp.txt", engine1)
#' 
#' engine2 = worker("hmm")
#' segment("./temp.txt", engine2)
#' 
#' engine2$write = T
#' segment("./temp.txt", engine2)
#'
#' engine3 = worker(type = "mix", dict = "dict_path",symbol = T)
#' segment("./temp.txt", engine3)
#'  }
#'  
#' \dontrun{
#' ### Keyword Extraction
#' engine = worker("keywords", topn = 1)
#' keywords(words, engine)
#' 
#' ### Speech Tagging 
#' tagger = worker("tag")
#' tagging(words, tagger)
#' 
#' ### Simhash
#' simhasher = worker("simhash", topn = 1)
#' simhash(words, simhasher)
#' distance("hello world" , "hello world!" , simhasher)
#' 
#' show_dictpath()
#' }
#' 
NULL 
