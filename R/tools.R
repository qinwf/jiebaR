#' Show default path of dictionaries
#' 
#' Show the default dictionaries' path. \code{HMMPATH}, \code{DICTPATH}
#' , \code{IDFPATH}, \code{STOPPATH} and \code{USERPATH} can be changed 
#' in default environment.
#' @author Qin Wenfeng 
#' 
#' @export
ShowDictPath<-function(){
  print(file.path(path.package("jiebaR"),"dict"))
}

#' Edit default user dictionary
#' 
#' Edit the default user dictionary. 
#' @references  The ictclas speech tag : \url{http://t.cn/8FdDD3I}
#' @details 
#' There are three column in the dictionary
#' . The first column is the word, the second column is the frequency
#' of words. The third column is speech tag using labels compatible
#'  with ictclas.
#' 
#' @author Qin Wenfeng 
#' @export
EditDict<-function(){
  file.show(file.path(path.package("jiebaR"),"dict","user.dict.utf8"))
}

