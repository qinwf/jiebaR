#' @export
mixcut<-function(code,file=NULL,output=paste0("rjieba",Sys.time(),".dat")
                 ,dict=NULL,hmm=NULL,user=NULL,symbol=F){
  if (!is.character(code) || length(code) != 1 )
    stop("Argument 'code' must be an string.")
  result<-mixcutc(code)
  if(symbol==F){
    result<-grep("[^[:punct:][:space:]，。、]", result,value = T)
  }
  if(.Platform$OS.type=="windows"){
    return (iconv(result,"UTF-8","GBK"))
  }
  return(result)
}
