#' @export
ShowDict<-function(){
  print(file.path(path.package("jiebaR"),"dict"))
}

#' @export
EditDict<-function(){
  file.show(file.path(path.package("jiebaR"),"dict","user.dict.utf8"))
}