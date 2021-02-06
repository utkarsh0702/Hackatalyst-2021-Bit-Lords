library("tidyverse")
library('data.table')

#### extract deaths by suicide per state in 2015-2020

years <- c('2015-Annual.csv','2016-Annual.csv','2017-Annual.csv','2018-Annual.csv','2019-Annual.csv','2020-Annual.csv')

new_mat <- matrix(data=NA, nrow=52,ncol = 6)

extract_suicide <- function(data_by_year,j){
  data_name <- read.csv(file= data_by_year)
  suicide_data <- data_name[grep("Suicide", data_name$`Measure.Name`),]
  uniq_names <- unique(suicide_data$'State.Name')
  
  for(i in 1:length(uniq_names)){
    obs_num <- filter(suicide_data, `State.Name`== uniq_names[i])
    sum1 <- sum(obs_num$Value,na.rm=TRUE)
    new_mat[i,j] <- sum1
  }
  return(new_mat)

}

for(k in 1:length(years)){
  new_mat<-extract_suicide(years[k],k)
}

new_mat2 <- data.frame(new_mat)

new_mat2[,7] <- unique(suicide_data$`State Name`)
colnames(new_mat2)=c("2015","2016","2017","2018","2019","2020","States")

plot(new_mat2[0,-7],new_mat2[1,-7])

jpeg('rplot.jpg')

plot(x=colnames(cum_sum[-7]), y=cum_sum[1,-7],type="o",lty=1,col="red"
     ,main="Total Deaths by Suicide from 2015-2020 in America",ylim=c(180,250),
     xlab = "Year",ylab = "Number of Deaths per 100 000 population")

dev.off()
#### extract covid cases per state in 2020

# covid_cases <- COVID_19[grep("COVID-19 Case Rate", COVID_19$`Measure Name`),]
# covid_cases_val <- select(covid_cases,"Value" )
# new_data <- data.frame("State Names" =uniq_names, "Suicide Deaths" =sum_vec, "Covid Cases" =covid_cases_val)
# 
# plot(new_data$Value,new_data$Suicide.Deaths,xlab = "Covid Cases by State", 
#      ylab="Suicide by Death by States",main="Relationship between Covid Cases and Suicides",ylim=c(0,600))
# 



