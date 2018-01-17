
library('tidyverse')
library('ggplot2')

reallife = read.csv('livebirths.csv', header=FALSE)

days = read.csv('birthdays.csv', header=FALSE)

days$V1 = as.Date(as.character(days$V1), format ='%m-%d')
days$month = as.integer(format(days$V1, format = '%m'))

dataframe <- as.data.frame(table(days$month))

reallife$percent = reallife$V2/sum(reallife$V2)
dataframe$percent = dataframe$Freq/sum(dataframe$Freq)

meanfreq = mean(dataframe$Freq)
deviation = sd(dataframe$Freq)

dataframe$diff = dataframe$percent - reallife$percent

meandiff = mean(dataframe$diff)
diffdeviation = sd(dataframe$diff)

names = c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
months <- dataframe$Var1
dataframe2 = data.frame(cbind(dataframe$Freq),names,months)

ggplot(dataframe2, aes(names, dataframe$Freq)) +   
  geom_bar(aes(fill = months), position = "dodge", stat="identity") + scale_x_discrete(limits=names) +
  geom_hline(yintercept = meanfreq, colour = "red", lwd = 1) +
  geom_hline(yintercept = meanfreq - deviation, colour = "black")+
  geom_hline(yintercept = meanfreq + deviation, colour = "black")+
  xlab("Month of Birth") +
  ylab("Frequency") +
  ggtitle("Frequency of Births per Month as Registered on Wikipedia") +
  labs(fill='Number of Month in Year')

ggplot(dataframe2, aes(x="", y=dataframe$Freq, fill=months))+
  geom_bar(width = 1, stat = "identity")+ 
  scale_y_reverse()+
  coord_polar("y")+
  ylab("Relative Frequency of Birth")+
  labs(fill='Number of Month in Year')

ggplot(dataframe2, aes(x="", y=reallife$V2, fill=months))+
  geom_bar(width = 1, stat = "identity")+ 
  scale_y_reverse()+
  coord_polar("y")+
  ylab("Relative Frequency of Birth")+
  labs(fill='Number of Month in Year')

ggplot(dataframe2, aes(x=dataframe$Var1, y=dataframe$diff))+
  geom_bar(mapping = aes(x=dataframe$Var1, y=dataframe$diff, fill = dataframe$Var1), stat='summary', fun.y=mean)+
  geom_hline(yintercept = meandiff, colour = "red", lwd = 1)+
  geom_hline(yintercept = meandiff - diffdeviation)+
  geom_hline(yintercept = meandiff + diffdeviation)+
  xlab("Month of Birth")+
  ylab("Difference in Relative Distributions of Births")+
  ggtitle("Difference in Relative Distributions of Births, Wikipedia vs UN Live Births")+
  labs(fill='Number of Month in Year')