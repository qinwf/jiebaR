print.inv<-function(x){
  invisible()
}
#' @export
`<=.segment`<-function(jiebar,code){
  if(file.exists(code) && jiebar$write==T) {
    segment(code,jiebar)
    xx<-NA
    class(xx) = "inv"
    return(xx)
  }
  else return(segment(code,jiebar))


}

#' @export
`<=.keywords`<-function(jiebar,code){
  keywords(code,jiebar)
}

#' @export
`<=.simhash`<-function(jiebar,code){
  simhash(code,jiebar)
}

#' @export
`<=.tagger`<-function(jiebar,code){
  if(file.exists(code) && jiebar$write==T) {
    tag(code,jiebar)
    xx<-NA
    class(xx) = "inv"
    return(xx)
  }
  else return(tag(code,jiebar))
}

#' @export
`==.simhash`<-function(jiebar,formula){
  distance(formula[[2]],formula[[3]],jiebar)
}
