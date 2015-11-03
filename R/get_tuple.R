#' get tuple from the segmentation result
#' @param x a character vector or list
#' @param size a integer >= 2
#' @param dataframe return data.frame
#' @examples 
#' get_tuple(c("sd","sd","sd","rd"),2)
#' @export
get_tuple = function(x,size=2,dataframe=T){
  stopifnot(size > 1)
  res = NULL
  if(inherits(x,"character")){
    stopifnot(length(x)>size)
    if(.Platform$OS.type=="windows"){
      x = enc2utf8(x)
    }
    res = get_tuple_vector(x,size)
  }
  if(inherits(x,"list")){
    if(.Platform$OS.type=="windows"){
      x = lapply(x,enc2utf8)
    }
    res = get_tuple_list(x,size)
  }
  if(.Platform$OS.type=="windows"){
    Encoding(names(res))="UTF-8"
  }
  if(dataframe == T) {
    dd = data.frame(name = names(res),count = unlist(res,use.names = FALSE),stringsAsFactors = F)
    return(dd[order(-dd[,2]),])
  }
  return(res)
}