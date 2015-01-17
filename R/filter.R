#' Filter segmentation result
#' This function helps remove some words in the segmentation result.
#' 
#' @param input a string vector
#' @param filter_words a string vector of words to be removed.
#' @export
filter_segment<- function(input,filter_words){
  grep(sprintf("(*UCP)(%s)", paste(filter_words, collapse = "|")), input,
       perl = TRUE,invert = TRUE,value = TRUE)
}