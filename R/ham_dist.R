#' Compute Hamming distance of Simhash value
# 
#' @param x a character vector of simhash value
#' @param y a character vector of simhash value
#' @return a character vector
#' @examples 
#' simhash_dist("1","1")
#' simhash_dist("1","2")
#' tobin("1")
#' tobin("2")
#' simhash_dist_mat(c("1","12","123"),c("2","1"))
#' @export
simhash_dist = function(x, y){
  stopifnot(is.character(x), is.character(y))
  cpp_ham_dist(x,y)
}

#' @rdname simhash_dist
#' @export
simhash_dist_mat = function(x, y){
  stopifnot(is.character(x), is.character(y))
  cpp_ham_dist_mat(x,y)
}