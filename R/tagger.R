#' Speech Tagging
#' 
#' The function uses Speech Tagging worker to cut word and 
#' tags each word after segmentation using labels compatible with 
#' ictclas.  \code{dict} 
#' \code{hmm} and \code{user} should be provided when initializing 
#' jiebaR worker.
#' 
#' There is a symbol \code{<=} for this function.
#' @seealso \code{\link{<=.tagger}} \code{\link{worker}} 
#' @param code a Chinese sentence or the path of a text file
#' @param jiebar jiebaR Worker
#' @references  The ictclas speech tag : \url{http://t.cn/RAEj7e1}
#' @examples 
#' \dontrun{
#' words = "hello world"
#' 
#' ### Speech Tagging 
#' tagger = worker("tag")
#' tagger <= words
#' }
#' @author Qin Wenfeng
#' @export
tagging<- function(code, jiebar) {
  stopifnot("jieba" %in% class(jiebar))
  if(jiebar$PrivateVarible$timestamp != TIMESTAMP){
    stop("Please create a new worker after jiebaR is reloaded.")
  }
  if (!is.character(code)) 
    stop("Argument 'code' must be an string.")
  
  if (file.exists(code[1]) && jiebar$write != "NOFILE") {
    if(length(code) > 1){
      warning("In file mode, only the first element will be processed.")
    }
    encoding<-jiebar$encoding
    
    if(is.null(jiebar$output)){
      basenames <- gsub("\\.[^\\.]*$", "", code[1])
      extnames  <- gsub(basenames, "", code[1], fixed = TRUE)
      times_char = gsub(" |:","_",as.character(Sys.time()))
      output    <- paste(basenames, ".segment.", times_char , extnames, sep = "")
    }  else {
      output<-jiebar$output
    }
    
    if(jiebar$detect==T)  encoding<-filecoding(code[1])
    
    FILESMODE <- T
    
    res = tagl(code = code, jiebar=jiebar,symbol = jiebar$symbol, lines = jiebar$lines, 
         output = output, encoding = encoding, write_file= jiebar$write,FILESMODE = FILESMODE)
    return(res)
  } else {
    if (.Platform$OS.type == "windows") {
      code<-enc2utf8(code)
    }
    FILESMODE <- F
    
    tagw(code = code, jiebar=jiebar,symbol=jiebar$symbol, 
         FILESMODE = FILESMODE)
  }
}

tagl <- function(code, jiebar, symbol, lines, output, encoding, write_file,FILESMODE) {
  
  nlines <- lines
  
  input.r <- file(code, open = "r")
  
  if(write_file==T){
    
    if (.Platform$OS.type == "windows") {
      output.w <- file(output, open = "ab", encoding = "UTF-8")
    } else {
      output.w <- file(output, open = "a", encoding = "UTF-8")
    }
    OUT <- FALSE
    
    tryCatch({
      while (nlines == lines) {
        tmp.lines <- readLines(input.r, n = lines, encoding = encoding)
        nlines <- length(tmp.lines)
        if(jiebar$bylines == FALSE){
          tmp.lines <- paste(tmp.lines, collapse = " ")
        }
        if (nlines > 0) {
          if (encoding != "UTF-8") {
            tmp.lines <- iconv(tmp.lines,encoding , "UTF-8")
          }
          out.lines <- tagw(code = tmp.lines, jiebar = jiebar, 
                            symbol = symbol, FILESMODE = FILESMODE)

          if (.Platform$OS.type == "windows") {
            
            if(jiebar$bylines == TRUE){
              lines_of_output <- length(out.lines)
              for(num in 1:lines_of_output){
                out.lines[[num]]<-gsub("\\s x\\s","",paste(out.lines[[num]], collapse = " "))
                writeBin(charToRaw(paste(out.lines[[num]], collapse = " ")), output.w)
                writeBin(charToRaw("\n"), output.w)
              }
            } else {
              out.lines<-gsub("\\s x\\s","",paste(out.lines, collapse = " "))
              writeBin(charToRaw(paste(out.lines, collapse = " ")), output.w)
            }
          } else {
            if(jiebar$bylines == TRUE){
              lines_of_output <- length(out.lines)
              for(num in 1:lines_of_output){
                out.lines[[num]]<-gsub("\\s x\\s","",paste(out.lines[[num]], collapse = " "))
                writeLines(paste(out.lines[[num]], collapse = " "), output.w)
                writeLines("\n", output.w)
              }
            } else {
              out.lines<-gsub("\\s x\\s","",paste(out.lines, collapse = " "))
              writeLines(paste(out.lines, collapse = " "), output.w)
            }
          }
          
        } 
      } 
    }
    , finally = {
      try(close(input.r), silent = TRUE)
      try(close(output.w), silent = TRUE)
      
    })
    OUT <- TRUE
    # cat(paste("Output file: ", output, "\n"))
    return(output) 
    
  } else{
    result<-c()
    FILESMODE=F
    
    tryCatch({
      while (nlines == lines) {
        tmp.lines <- readLines(input.r, n = lines, encoding = encoding)
        nlines <- length(tmp.lines)
        if(jiebar$bylines == FALSE){
          tmp.lines <- paste(tmp.lines, collapse = " ")
        }
        if (nlines > 0) {
          if (encoding != "UTF-8") {
            tmp.lines <- iconv(tmp.lines,encoding , "UTF-8")
          }
          out.lines <- tagw(code = tmp.lines, jiebar = jiebar, 
                            symbol = symbol, FILESMODE = FILESMODE)
          
          result<-c(result,out.lines)

        } 
      } 
    }
    , finally = {
      try(close(input.r), silent = TRUE)
      
    })
    
    return(result)
  }
  
}


tagw <- function(code, jiebar,  symbol, FILESMODE) {
  
#   if (symbol == F) {
#     code <- gsub("[^\u2e80-\u3000\u3021-\ufe4fa-zA-Z0-9]", " ", code)
#   } 
#   #  code <- gsub("^\\s+|\\s+$", "", gsub("\\s+", " ", code))
  if(jiebar$bylines == FALSE){
    if(length(code) > 1){
      code <- paste(code, collapse = " ")
    }
    if(FILESMODE==T && symbol == T){
        result <- jiebaclass_tag_file(code,jiebar$worker)
    } else{
        result <- jiebaclass_tag_tag(code,jiebar$worker)
    }
    
    if (symbol == F && FILESMODE  ==F) {
      result = result[ result != " "]
    }
    
    if (.Platform$OS.type == "windows") {
      Encoding(result)<-"UTF-8"
    }

    if(FILESMODE==T && symbol == F){
      result = grep("(*UCP)^[^\u2e80-\u3000\u3021-\ufe4fa-zA-Z0-9]*$", result, perl = TRUE,value = TRUE,invert = T)
      result = paste(result,names(result),collapse = " ")
    }

    if (symbol == F && FILESMODE  == F) {
      result <- grep("(*UCP)^[^\u2e80-\u3000\u3021-\ufe4fa-zA-Z0-9]*$", result, perl = TRUE,value = TRUE,invert = T)
    }

  } else{
    
    length_of_input = length(code)
    result = vector("list", length_of_input)
    
    for(num in 1:length_of_input){
      if(FILESMODE==T && symbol == T){
          tmp_result <- jiebaclass_tag_file(code[num], jiebar$worker)
        
      } else{
          tmp_result <- jiebaclass_tag_tag(code[num],jiebar$worker)
      }
      
      if (symbol == F && FILESMODE  == F) {
        tmp_result = tmp_result[ tmp_result != " "]
      }
      
      if (.Platform$OS.type == "windows") {
        Encoding(tmp_result)<-"UTF-8"
      }

      if(FILESMODE==T && symbol == F){
        tmp_result = grep("(*UCP)^[^\u2e80-\u3000\u3021-\ufe4fa-zA-Z0-9]*$", tmp_result, perl = TRUE,value = TRUE,invert = T)
        tmp_result = paste(tmp_result,names(tmp_result),collapse = " ")
      }

      if (FILESMODE == F && symbol == F) {
        tmp_result <- grep("(*UCP)^[^\u2e80-\u3000\u3021-\ufe4fa-zA-Z0-9]*$", tmp_result, perl = TRUE,value = TRUE,invert = T)
      }
      
      result[[num]] = tmp_result
    }
  }
  result
}
