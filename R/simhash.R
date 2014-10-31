#' @export
simhash <- function(code, jiebar) {
  
  if (!is.character(code) || length(code) != 1) 
    stop("Argument 'code' must be an string.")
  if (file.exists(code)) {
    encoding<-jiebar$Encoding
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
  
  if (jiebar$Symbol == F) {
    code <- gsub("[^\u4e00-\u9fa5a-zA-Z0-9]", " ", code)
  } 
  code <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", code))

    result <- jiebar$Worker$simhash(code,jiebar$Top_N_Words)

  if (.Platform$OS.type == "windows") {
    result$keyword<-iconv(result$keyword, "UTF-8", "GBK")
    
    return(result)
  }
  return(result)
} 
