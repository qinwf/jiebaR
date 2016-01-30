#' Show default path of dictionaries
#' 
#' Show the default dictionaries' path. \code{HMMPATH}, \code{DICTPATH}
#' , \code{IDFPATH}, \code{STOPPATH} and \code{USERPATH} can be changed 
#' in default environment.
#' @author Qin Wenfeng 
#' 
#' @export
show_dictpath<-function(){
  print(file.path(path.package("jiebaRD"),"dict"))
}

#' Edit default user dictionary
#' 
#' Edit the default user dictionary. 
#' @references  The ictclas speech tag : \url{http://t.cn/RAEj7e1}
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
  if (.Platform$OS.type == "windows") {
    file.show(file.path(path.package("jiebaRD"),"dict",dictname))
    warning("You should save the dictionary without BOM on Windows")
  } else{
    file.edit(file.path(path.package("jiebaRD"),"dict",dictname))
  }
}
