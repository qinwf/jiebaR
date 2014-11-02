#' @export
simhash <- function(code, jiebar) {
  
  if (!is.character(code) || length(code) != 1) 
    stop("Argument 'code' must be an string.")
  if (file.exists(code)) {
    encoding<-jiebar$encoding
    if(detect==T)  encoding<-filecoding(code)
    simhashl(code = code, jiebar = jiebar,
         encoding = encoding)
  } else {
    simhashw(code = code, jiebar = jiebar)
             
    
  }
}

simhashl <- function(code, jiebar, encoding) {
  
  input.r <- file(code, open = "r")
  OUT <- FALSE
  tryCatch({
    
    tmp.lines <- readLines(input.r,  encoding = encoding)
    nlines <- length(tmp.lines)
    tmp.lines <- paste(tmp.lines, collapse = " ")
    if (nlines > 0) {
      if (encoding != "UTF-8") {
        tmp.lines <- iconv(tmp.lines,encoding , "UTF-8")
      } 
      out.lines <- simhashw(code = tmp.lines, jiebar = jiebar)
    }
    return(out.lines)
  }, finally = {
    try(close(input.r), silent = TRUE)
  })
}


simhashw <- function(code, jiebar) {
  
  if (jiebar$symbol == F) {
    code <- gsub("[^\u4e00-\u9fa5a-zA-Z0-9]", " ", code)
  } 
  code <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", code))

    result <- jiebar$worker$simhash(code,jiebar$topn)

  if (.Platform$OS.type == "windows") {
    result$keyword<-iconv(result$keyword, "UTF-8", "GBK")
    
    return(result)
  }
  return(result)
} 

#' @export
distance<-function(codel,coder,jiebar){
  if (!is.character(codel) || length(codel) != 1 ||
        !is.character(coder) || length(coder) != 1) 
    stop("Argument 'code' must be an string.")
  encoding<-jiebar$encoding

  if (file.exists(codel)) {
    if(jiebar$detect==T)  encoding<-filecoding(codel)
    codel<-distancel(codel,jiebar,encoding)
  }
  if (file.exists(coder)) {
    if(jiebar$detect==T)  encoding<-filecoding(coder)
    coder<-distancel(coder,jiebar,encoding)
  }
  result<-jiebar$worker$distance(codel,coder,jiebar$topn)
  if (.Platform$OS.type == "windows") {
    result$lhs<-iconv(result$lhs, "UTF-8", "GBK")
    result$rhs<-iconv(result$rhs, "UTF-8", "GBK")
  }
  result  
}


distancel <- function(code, jiebar, encoding) {
  
  input.r <- file(code, open = "r")
  OUT <- FALSE
  tryCatch({
    
    tmp.lines <- readLines(input.r,  encoding = encoding)
    nlines <- length(tmp.lines)
    tmp.lines <- paste(tmp.lines, collapse = " ")
    if (nlines > 0) {
      if (encoding != "UTF-8") {
        tmp.lines <- iconv(tmp.lines,encoding , "UTF-8")
      } 
      if (jiebar$symbol == F) {
        tmp.lines <- gsub("[^\u4e00-\u9fa5a-zA-Z0-9]", " ", tmp.lines)
      } 
      tmp.lines <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", tmp.lines))
      
    }
    return(tmp.lines)
  }, finally = {
    try(close(input.r), silent = TRUE)
  })
}
