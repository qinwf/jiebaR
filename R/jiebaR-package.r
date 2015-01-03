#' A package for Chinese text segmentation
#'
#' This is a package for Chinese text segmentation, keyword extraction 
#' and speech tagging with Rcpp and cppjieba. JiebaR supports four 
#' types of segmentation mode: Maximum Probability, Hidden Markov Model, 
#' Query Segment and Mix Segment. 
#' 
#' You can use custom 
#' dictionary to be included in the jiebaR default dictionary. JiebaR can 
#' also identify new words, but adding your own new words will ensure a higher 
#' accuracy.
#' @docType package
#' @name jiebaR
#' @author Qin Wenfeng <\url{http://qinwenfeng.com}>
#' @references CppJieba \url{https://github.com/aszxqw/cppjieba};
#' @seealso JiebaR \url{https://github.com/qinwf/jiebaR};
#' @examples 
#' ### Note: Can not display Chinese character here.
#' \dontrun{
#' words = "hello world"
#' test1 = worker()
#' test1 <= words
#' }
#' 
#' \dontrun{
#' test <= "./temp.txt"
#' engine2 = worker("hmm")
#' engine2 <= "./temp.txt"
#' engine2$write = T
#' engine2 <= "./temp.txt"
#' engine3 = worker(type = "mix", dict = "dict_path",symbol = T)
#' engine3 <= "./temp.txt"
#'  }
#' \dontrun{
#' ### Keyword Extraction
#' keys = worker("keywords", topn = 1)
#' keys <= words
#' 
#' ### Speech Tagging 
#' tagger = worker("tag")
#' tagger <= words
#' 
#' ### Simhash
#' simhasher = worker("simhash", topn = 1)
#' simhasher <= words
#' distance("hello world" , "hello world!" , simhasher)
#' 
#' show_dictpath()
#' }
#' 
NULL 
