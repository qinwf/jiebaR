#' Show default path of dictionaries
#' 
#' Show the default dictionaries' path. \code{HMMPATH}, \code{DICTPATH}
#' , \code{IDFPATH}, \code{STOPPATH} and \code{USERPATH} can be changed 
#' in default environment.
#' @author Qin Wenfeng 
#' 
#' @export
show_dictpath<-function(){
  print(file.path(path.package("jiebaR"),"dict"))
}

#' @rdname show_dictpath
#' @export
ShowDictPath<-function(){
  print(file.path(path.package("jiebaR"),"dict"))
  warning("ShowDictPath() was deprecated. Please use show_dictpath() instead.")
}

#' Edit default user dictionary
#' 
#' Edit the default user dictionary. 
#' @references  The ictclas speech tag : \url{http://t.cn/8FdDD3I}
#' @details 
#' There are three column in the system dictionary. The first column is the word, 
#' and the second column is the frequency of word. The third column is 
#' speech tag using labels compatible with ictclas.
#' 
#' There are two column in the user dictionary. The first column is the word, 
#' and the second column is speech tag using labels compatible with ictclas.
#' Frequency of every word in the user dictionary will be the maximum number of 
#' the system dictionary. If you want to provide the frequency of a new word,
#' you can put it in the system dictionary.
#' 
#' @param name the name of dictionary including \code{user}, \code{system},
#' \code{stop_word}.
#' @author Qin Wenfeng 
#' @export
edit_dict<-function(name = "user"){
  if(!(name %in% c("user","system","stop_word"))){
    stop("Unkown name type")
  }
  dictname = switch(name,
                    user   =  "user.dict.utf8",
                    
                    system = {
                      warning("Open system dictionary will take a long time")
                      "jieba.dict.utf8"
                    },
                    
                    stop_word = "stop_words.utf8"
  )
  file.show(file.path(path.package("jiebaR"),"dict",dictname))
  if (.Platform$OS.type == "windows") {
    warning("You should save the dictionary without BOM on Windows")
  }
}

#' @rdname edit_dict
#' @export
EditDict<-function(name = "user"){
  edit_dict(name)
  warning("EditDict was deprecated. Please use edit_dict() instead.")
  
}