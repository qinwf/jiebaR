#' apply list input
#' @param worker a worker
#' @param input a list
#' @examples 
#' cutter = worker()
#' apply_list(list("this is test", "that is not test"), cutter)
#' @export
apply_list = function(input, worker){
  if (!is.list(input)){
    
    if(is.character(input)){
      return(worker[input])
    }else{
      # will not do anything
      return(input)
    }
  }else{
    # input is list and we will contruct the result
    len = length(input)
    res = vector("list", len)
    for( x in 1:len ){
      res[[x]] = apply_list(input[[x]],worker)
    }
    return(res)
  }
}