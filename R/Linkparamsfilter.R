#' Link parameters filter
#'
#' This function remove a given set of parameters from a specific URL
#' @param URL character, the URL from which params and values have to be removed
#' @param params character vector, List of url parameters to be removed
#' @return return a URL wihtout given parameters
#' @author salim khalil
#' @details
#' This function exclude given parameters from the urls,
#' @export
#' @examples
#' url<-"http://www.glogile.com/index.php?name=jake&age=23&tmp=2&ord=1"
#' url<-Linkparamsfilter(url,c("ord","tmp"))
#'
#' #exclude filter and template parameters from URL.
#'
Linkparamsfilter<-function(URL, params){
  str<-URL
  paramsv<-Linkparameters(str)
  if (!is.null(paramsv)){
  #extract parameters names
  paramsid<-unlist(lapply(paramsv, FUN = function(el) gsub("(.*)\\=.*", "\\1", el)))
  nbparams<-length(paramsid)
  for (i in 1:length(params)){
  #if the parameter exist in the url
      if(params[i] %chin% paramsid) {
        paramsv<-Linkparameters(str)
        nbparams<-length(unlist(lapply(paramsv, FUN = function(el) gsub("(.*)\\=.*", "\\1", el))))
        if (nbparams>1) {
            paramsi<-grep(paste("^",params[i],"$", sep = ""), paramsid)
            if(paramsi>1){
              pat<-paste("&",paramsv[paramsi],sep="")
              str<-gsub(pat,'',str)
            } else {
              pat<-paste(paramsv[paramsi],"&",sep="")
              str<-gsub(pat,'',str)
            }
        } else {
          paramsi<-grep(paste("^",params[i],"$", sep = ""), paramsid)
          pat<-paste("\\?",paramsv[paramsi],sep="")
          str<-gsub(pat,'',str)
        }
      }
  }
  } else str<-URL
  return (str)
}
