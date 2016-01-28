#' @rdname print.jieba
#' @export
print.inv<-function(x, ...){
  invisible()
}

#' Text segmentation symbol
#' 
#' Text segmentation symbol to cut words.
#' @param jiebar jiebaR Worker.
#' @param code   A Chinese sentence or the path of a text file. 
#' @author Qin Wenfeng <\url{http://qinwenfeng.com}>
#' @examples 
#' \dontrun{
#' words = "hello world"
#' test1 = worker()
#' test1 <= words}
#' @export
`<=.segment`<-function(jiebar, code){
#   if(jiebar$write == T) {
#     segment(code,jiebar)
#     xx<-NA
#     class(xx) = "inv"
#     return(xx)
#   }
#   else 
    return(segment(code, jiebar))
}

#' @rdname less-than-equals-.segment
#' @export
`[.segment`<- `<=.segment`

#' Keywords symbol
#' 
#' Keywords symbol to find keywords.
#' @param jiebar jiebaR Worker.
#' @param code   A Chinese sentence or the path of a text file. 
#' @author Qin Wenfeng <\url{http://qinwenfeng.com}>
#' @examples 
#' \dontrun{
#' words = "hello world"
#' test1 = worker("keywords",topn=1)
#' test1 <= words}
#' @export
`<=.keywords` <- function(jiebar, code){
  keywords(code, jiebar)
}

#' @rdname less-than-equals-.keywords
#' @export
`[.keywords`<- `<=.keywords`

#' Simhash symbol
#' 
#' Simhash symbol to compute simhash.
#' @param jiebar jiebaR Worker.
#' @param code   A Chinese sentence or the path of a text file. 
#' @author Qin Wenfeng <\url{http://qinwenfeng.com}>
#' @examples 
#' \dontrun{
#' words = "hello world"
#' test1 = worker("simhash",topn=1)
#' test1 <= words}
#' @export
`<=.simhash` <- function(jiebar,code){
  simhash(code, jiebar)
}

#' @rdname less-than-equals-.simhash
#' @export
`[.simhash`<- `<=.simhash`

#' Tagger symbol
#' 
#' Tagger symbol to tag words.
#' @param jiebar jiebaR Worker.
#' @param code   A Chinese sentence or the path of a text file. 
#' @author Qin Wenfeng <\url{http://qinwenfeng.com}>
#' @examples 
#' \dontrun{
#' words = "hello world"
#' test1 = worker("tag")
#' test1 <= words}
#' @export
`<=.tagger`<-function(jiebar, code){
#   if(file.exists(code) && jiebar$write == T) {
#     tagging(code, jiebar)
#     xx <- NA
#     class(xx) = "inv"
#     return(xx)
#   }
#   else 
    return(tagging(code, jiebar))
}

#' @rdname less-than-equals-.tagger
#' @export
`[.tagger`<- `<=.tagger`
