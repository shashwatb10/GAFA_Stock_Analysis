setwd("~/R tutorial 7/GAGA Stock Analysis")
stats<-read.csv("GAFA Stock Prices.csv")
stats$PosixDate<-as.POSIXct(stats$Date, format="%d/%m/%Y")

stats_google<-stats[stats$Stock %in% c("Google"),]
stats_Apple<-stats[stats$Stock %in% c("Apple"),]
stats_Facebook<-stats[stats$Stock %in% c("Facebook"),]
stats_Amazon<-stats[stats$Stock %in% c("Amazon"),]

library(ggplot2)
plot1<-ggplot(data=stats_google, aes(x=PosixDate, y=Adj.Close))+geom_point(size=1, aes(colour=Stock))+ggtitle("Google Stock Prices over the Years")+ylab("Stock Price")+
  theme(axis.text.y=element_blank())
plot1
