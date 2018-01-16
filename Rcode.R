library('tidyverse')
library('ggplot2')


bdays = read.csv('birthdates.csv', header=FALSE)

names(bdays) = c("months")


bmonth = bdays %>%
  filter(months %in% range(1,13))

dataframe <- as.data.frame(table(bdays))


ggplot(data = dataframe)+
  geom_bar(mapping = aes(x=dataframe$bdays, y=dataframe$Freq), stat='summary', fun.y=mean)+
  geom_abline(mapping = aes(mean(dataframe$Freq)))+
error.bars(x,stats=NULL, ylab = "Dependent Variable",xlab="Independent Variable",
             main=NULL,eyes=TRUE, ylim = NULL, xlim=NULL,alpha=.05,sd=FALSE, labels = NULL, 
             pos = NULL,  arrow.len = 0.05,arrow.col="black", add = FALSE,bars=FALSE,within=FALSE,
             col="blue",...)



ggplot(data = bdays)+
  geom_bar(mapping = aes(x=months), stat='summary', fun.y=mean)+
  abline(mean())