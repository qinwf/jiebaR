#' @export
`<=.segment`<-function(jiebar,code){
  segment(code,jiebar)
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
  tag(code,jiebar)
}
