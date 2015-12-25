yahooStockMajor.getData <- function(stockID = 2330){
  library(httr)
  library(rvest)
  
  ## Connector
  Target_URL = paste0("http://tw.stock.yahoo.com/d/s/major_",as.character(stockID),".html")
  res <- GET(Target_URL)
  doc_str <- content(res, type = "text", encoding = "big5")
  
  ## Parser
  if (.Platform$OS.type == "windows"){
    Sys.setlocale(category='LC_ALL', locale='C')
    data_table <- doc_str %>% read_html(encoding = "big-5") %>% html_nodes(xpath = "//table[1]//table[2]") %>% html_table(header=TRUE)
    Sys.setlocale(category='LC_ALL', locale='cht')
    data_table <- apply(data_table[[1]],2,function(x) iconv(x,from = "utf8"))
    colnames(data_table) <- iconv(colnames(data_table), from = "utf8")
  }  else{
    data_table <- doc_str %>% read_html(encoding = "big-5") %>% html_nodes(xpath = "//table[1]//table[2]") %>% html_table(header=TRUE)
    data_table <- data_table[[1]]
  }
  
  data_table
}