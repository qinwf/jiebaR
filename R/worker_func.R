#' Add user word
#' 
#' @param worker a jieba worker
#' @param words the new words
#' @param tags the new words tags, default "n"
#' @examples
#' cc = worker()
#' new_user_word(cc, "test")
#' new_user_word(cc, "do", "v")
#' @export
new_user_word = function(worker, words, tags = rep("n", length(words))){
  stopifnot(inherits(worker,"jieba"), length(words) == length(tags), is.character(words), is.character(tags))
  if (.Platform$OS.type == "windows") {
    words <- enc2utf8(words)
    tags <- enc2utf8(tags)
  }
  add_user_word(words,tags,worker$worker)
}
