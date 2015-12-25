packages <- c("plotly","ggplot2","dplyr")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())),repos="http://cran.r-project.org")
}
library(ggplot2)
library(plotly)
library(dplyr)
# save(Xmas,file = "Sportlottery_Xmas")
load("Sportlottery_Xmas")

plot_ly(Xmas, x = BefourHour, y = HM_Odd, 
        color = Game, text = Home.Team) %>% 
  add_trace(y = AM_Odd, color = Game, text = Away.Team) %>% 
  layout(yaxis = list(title = "Odds"), 
         title = "最近24小時主場賠率變化 (20151225 22:00)",
         showlegend = FALSE)



