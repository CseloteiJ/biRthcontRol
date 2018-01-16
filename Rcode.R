<<<<<<< HEAD
library('tidyverse')
library('ggplot2')


bdays = read.csv('birthdates.csv', header=FALSE)

names(bdays) = c("months")

dataframe <- as.data.frame(table(bdays))

meanfreq = mean(dataframe$Freq)
deviation = sd(dataframe$Freq)

dataframe$bdays = as.integer(dataframe$bdays)
dataframe$bdays = as.factor(dataframe$bdays)

dataframe$bdays[0]

ggplot()+
  geom_bar(mapping = aes(x=dataframe$bdays, y=dataframe$Freq), stat='summary', fun.y=mean)+
  geom_hline(yintercept = meanfreq, colour = "red", lwd = 1)+
  geom_hline(yintercept = meanfreq - deviation)+
  geom_hline(yintercept = meanfreq + deviation)+
  xlab("Month of Birth")+
  ylab("Frequency")+
  ggtitle("Frequency of Births per Month as Registered on Wikipedia")


dataframe.for.bitter.nonjanuary.losers = dataframe %>%
  filter(dataframe$bdays >= 2)

dataframe.for.bitter.nonjanuary.losers$bdays = as.factor(dataframe.for.bitter.nonjanuary.losers$bdays)

meanfreqnonjan = mean(dataframe.for.bitter.nonjanuary.losers$Freq)
deviationnonjan = sd(dataframe.for.bitter.nonjanuary.losers$Freq)

ggplot()+
  geom_bar(mapping = aes(x=dataframe.for.bitter.nonjanuary.losers$bdays, y=dataframe.for.bitter.nonjanuary.losers$Freq), stat='summary', fun.y=mean)+
  geom_hline(yintercept = meanfreqnonjan, colour = "red", lwd = 1)+
  geom_hline(yintercept = meanfreqnonjan - deviationnonjan)+
  geom_hline(yintercept = meanfreqnonjan + deviationnonjan)+
  xlab("Month of Birth")+
  ylab("Frequency")+
  ggtitle("Frequency of Births per Month as Registered on Wikipedia")