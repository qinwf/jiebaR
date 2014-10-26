#' @export
mixcut<-function(code,file=NULL,output=paste0("rjieba",Sys.time(),".dat")
                 ,dict=NULL,hmm=NULL,user=NULL){
  if (!is.character(code) || length(code) != 1 )
    stop("Argument 'code' must be an string.")
  result<-mixcutc(code)
  if(.Platform$OS.type=="windows"){
    return (iconv(result,"UTF-8","GBK"))
  }
  return(result)
}
