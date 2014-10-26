.onLoad <- function(libname, pkgname) {
  if(.Platform$OS.type=="windows"){
  Sys.setlocale(locale="English")}
}

#' @export
mixcut<-function(code,file=NULL,output=paste0("rjieba",Sys.time(),".dat")
                 ,dict=NULL,hmm=NULL,user=NULL,symbol=F){
  if (!is.character(code) || length(code) != 1 )
    stop("Argument 'code' must be an string.")
  if(symbol==F){
    code<-gsub("[^\u4e00-\u9fa5a-zA-Z0-9]", " ", code)
  }
  code <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", code))
  result<-mixcutc(code)
  if(symbol==F){
    result<-grep("[^[:space:]]", result,value = T)
  }
  if(.Platform$OS.type=="windows"){
    result<-iconv(result,"UTF-8","GBK")
    return (result)
  }
  return(result)
}
