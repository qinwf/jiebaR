#' Init Worker
#' 
#' @export
fenci_init = function(){
  
}


# THULAC -----------

#' Download THULAC Model
#' 
#' @export
#' 
#' @examples
#' 
#' \dontrun{
#' download_thulac_model()
#' }
download_thulac_model = function(model_url = "http://thulac.thunlp.org/source/Models_v1_v2.zip"){
  cat(thulac_policy)
  
  package_path = get_thulacr_path()
  temppath = tempdir()
  if (file.exists(model_url)){
    file.copy(model_url, file.path(temppath,"model.zip"))
  } else {
    download.file(model_url,file.path(temppath,"model.zip"))
  }
  unzip(file.path(temppath,"model.zip"),exdir = file.path(package_path))
}

#' Get jiebaR Package Path
#' 
#' @export
#' 
#' @param index If there are multiple jiebaR installed in the system, select one of them to use.
#' 
#' @examples
#' 
#' \dontrun{
#' get_thulac_path()
#' }
get_thulacr_path = function(index = 1){
  sp = searchpaths()
  thulacr_path = grep(pattern = "jiebaR", x = sp)
  if(length(thulacr_path) < 1){
    stop("jiabaR is not in the list of search paths. Run seachpaths() to get the list of search paths.")
  }
  sp[thulacr_path[index]]
}
