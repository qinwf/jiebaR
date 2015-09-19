
#' Filter segmentation result
#' This function helps remove some words in the segmentation result.
#' 
#' @param input a string vector
#' @param filter_words a string vector of words to be removed.
#' @param unit the length of word unit to use in regular expression, and the default is 50. Long list of a words forms a big regular expressions, it may or may not be accepted: the POSIX standard only requires up to 256 bytes. So we use unit to split the words in units.
#' @export
filter_segment <- function(input,filter_words,unit=50){
  length_words = length(filter_words)
  list_length = ceiling(length_words / unit)
  
  if (length_words == 0) return(input)
  
  regx_list = suppressWarnings(split(filter_words,1:list_length))
  
  for (i in 1:list_length) {
    regx_list[[i]] = sprintf("(*UCP)^(%s)$", paste(regx_list[[i]], collapse = "|"))
  }
  
  # begin filter
  if (all("character" %in% sapply(input,FUN = class)) || "character" %in% class(input))
  {
    if ("character" %in% class(input)) {
      # input is vector
      for (j in 1:list_length) {
        input = grep(regx_list[[j]], input, perl = TRUE,invert = TRUE,value = TRUE)
      }
      
    } else # input is a list
    {
      for (j in 1:list_length) {
        input  = lapply(input, function(input,regx) grep(regx, input, perl = TRUE,invert = TRUE,value = TRUE),regx_list[[j]])
      }

    }
    return(input)
  } else # no matching class
  {
    stop("Error: unsupported input format.\nYou should provide a list of character vectors or only a character vector")
  }
  
}
