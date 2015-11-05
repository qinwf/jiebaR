#' simhash value to binary
#' @param x simhash value
#' @export
tobin = function(x){
  stopifnot(length(x)==1 && inherits(x,"character"))
  u64tobin(x)
}
