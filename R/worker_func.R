#' Set query threshold
#' 
#' @param worker a jieba worker
#' @param number the query threshold
#' @export
query_threshold = function(worker, number){
  stopifnot(inherits(worker,"jieba"))
  set_query_threshold(number,worker$worker)
  worker$max_word_length = number
}

#' Add user word
#' 
#' @param worker a jieba worker
#' @param words the new words
#' @param tags the new words tags
#' @export
new_user_word = function(worker, words, tags){
  stopifnot(inherits(worker,"jieba"), length(words) == length(tags), is.character(words), is.character(tags))
  if (.Platform$OS.type == "windows") {
    words <- enc2utf8(words)
    tags <- enc2utf8(tags)
  }
  add_user_word(words,tags,worker$worker)
}
#' Get text location
#' 
#' @param words a string
#' @return a list with words, start position, and end position
#' @export
words_locate = function(words){
  if (.Platform$OS.type == "windows") {
    words <- enc2utf8(words)
  }
  res = get_loc(words)
  if (.Platform$OS.type == "windows") {
    Encoding(res[[1]]) = "UTF-8"
  }
  res
}
