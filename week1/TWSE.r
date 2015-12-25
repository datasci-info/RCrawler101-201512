TWSE.postData <- function(step = "1", TYPEK = "sii", code = ""){
  library(httr)
  library(rvest)
  ## Connector
  gen_body <- paste0("encodeURIComponent=1&step=",as.character(step),
  "&firstin=1&TYPEK=",as.character(TYPEK),"&code=",as.character(code))
  res <- POST("http://mops.twse.com.tw/mops/web/ajax_t51sb01",body = gen_body)
  doc_str <- content(res, "text", encoding = "utf8")
  write(doc_str, file = "mops.html")
  
  ## Parser
  if (.Platform$OS.type == "windows"){
    Sys.setlocale(category='LC_ALL', locale='C')
    data_table <- doc_str %>% read_html(encoding = "big-5") %>% html_nodes(xpath = "//table[2]") %>% html_table(header=TRUE)
    Sys.setlocale(category='LC_ALL', locale='cht')
    data_table <- apply(data_table[[1]],2,function(x) iconv(x,from = "utf8"))
    colnames(data_table) <- iconv(colnames(data_table), from = "utf8")
  }  else{
    data_table <- doc_str %>% read_html(encoding = "big-5") %>% html_nodes(xpath = "//table[2]") %>% html_table(header=TRUE)
    data_table <- data_table[[1]]
  }

  data_table
}