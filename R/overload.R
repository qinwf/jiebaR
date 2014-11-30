#' @rdname print.hmmseg
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
#' \donttest{
#' words = "hello world"
#' test1 = worker()
#' test1 <= words}
#' @export
`<=.segment`<-function(jiebar, code){
  if(file.exists(code) && jiebar$write == T) {
    segment(code,jiebar)
    xx<-NA
    class(xx) = "inv"
    return(xx)
  }
  else return(segment(code, jiebar))


}

#' Keywords symbol
#' 
#' Keywords symbol to find keywords.
#' @param jiebar jiebaR Worker.
#' @param code   A Chinese sentence or the path of a text file. 
#' @author Qin Wenfeng <\url{http://qinwenfeng.com}>
#' @examples 
#' \donttest{
#' words = "hello world"
#' test1 = worker("keywords",topn=1)
#' test1 <= words}
#' @export
`<=.keywords` <- function(jiebar, code){
  keywords(code, jiebar)
}

#' Simhash symbol
#' 
#' Simhash symbol to compute simhash.
#' @param jiebar jiebaR Worker.
#' @param code   A Chinese sentence or the path of a text file. 
#' @author Qin Wenfeng <\url{http://qinwenfeng.com}>
#' @examples 
#' \donttest{
#' words = "hello world"
#' test1 = worker("simhash",topn=1)
#' test1 <= words}
#' @export
`<=.simhash` <- function(jiebar,code){
  simhash(code, jiebar)
}

#' Tagger symbol
#' 
#' Tagger symbol to tag words.
#' @param jiebar jiebaR Worker.
#' @param code   A Chinese sentence or the path of a text file. 
#' @author Qin Wenfeng <\url{http://qinwenfeng.com}>
#' @examples 
#' \donttest{
#' words = "hello world"
#' test1 = worker("tag")
#' test1 <= words}
#' @export
`<=.tagger`<-function(jiebar, code){
  if(file.exists(code) && jiebar$write == T) {
    tagging(code, jiebar)
    xx <- NA
    class(xx) = "inv"
    return(xx)
  }
  else return(tagging(code, jiebar))
}

#' Distance symbol
#' 
#' Distance symbol to compute distance.  This symbol is deprecated, and
#' please use \code{\link{distance}} instead.
#' @param jiebar jiebaR Worker.
#' @param formula  Two Chinese sentence or the path of text file. 
#' @author Qin Wenfeng <\url{http://qinwenfeng.com}>
#' @seealso \code{\link{distance}}
#' @examples 
#' \donttest{
#' test1 = worker("simhash",topn=1)
#' test1 == ( "hello world" ~ "hello world")}
#' @export
`==.simhash` <- function(jiebar,formula){
  warning("==.simhash() was deprecated. Please use distance() instead.\n")
  distance(formula[[2]], formula[[3]], jiebar)
}
