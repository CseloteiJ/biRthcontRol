#import packages
library('tidyverse')
library('ggplot2')

#read csv files into R
reallife = read.csv('livebirths.csv', header=FALSE)
days = read.csv('birthdays.csv', header=FALSE)

#convert columns into specified formats: here they're converted to date and integer format
days$V1 = as.Date(as.character(days$V1), format ='%m-%d')
days$month = as.integer(format(days$V1, format = '%m'))

#create the dataframe of the wikipedia data for further processing
dataframe <- as.data.frame(table(days$month))

#calculate the percentage of births for each month, for both datasets
reallife$percent = reallife$V2/sum(reallife$V2)
dataframe$percent = dataframe$Freq/sum(dataframe$Freq)

#calculate the mean and standard deviation for the wikipedia data
meanfreq = mean(dataframe$Freq)
deviation = sd(dataframe$Freq)

#calculate the differences in month percentage between the wikipedia data and the UN data
dataframe$diff = dataframe$percent - reallife$percent

#calculate the mean and standard deviation of the difference in percentage
meandiff = mean(dataframe$diff)
diffdeviation = sd(dataframe$diff)

#generate necessary lists and dataframes for use within the ggplot: here the most important ones are creating a new dataframe
#that combines everything we need, as well as a 'names' list for the x-axis.
names = c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
months <- dataframe$Var1
dataframe2 = data.frame(cbind(dataframe$Freq),names,months)

#create the first graph whcih contains the frequency of births per month
#make sure to include the 'scale_x_discrete' function which allows you to label the x-axis using the above list
#use the 'geom_hline' function to include the mean and standard deviation as lines on the graph
ggplot(dataframe2, aes(names, dataframe$Freq)) +   
  geom_bar(aes(fill = months), position = "dodge", stat="identity") + scale_x_discrete(limits=names) +
  geom_hline(yintercept = meanfreq, colour = "red", lwd = 1) +
  geom_hline(yintercept = meanfreq - deviation, colour = "black")+
  geom_hline(yintercept = meanfreq + deviation, colour = "black")+
  xlab("Month of Birth") +
  ylab("Frequency") +
  ggtitle("Frequency of Births per Month as Registered on Wikipedia") +
  labs(fill='Number of Month in Year')

#create the second graph whcih contains the percentages of births per month in the wiki data as a pie chart
ggplot(dataframe2, aes(x="", y=dataframe$Freq, fill=months))+
  geom_bar(width = 1, stat = "identity")+ 
  scale_y_reverse()+
  coord_polar("y")+
  ylab("Relative Frequency of Birth")+
  labs(fill='Number of Month in Year')

#create the third graph whcih contains the percentages of births per month in the UN data as a pie chart
ggplot(dataframe2, aes(x="", y=reallife$V2, fill=months))+
  geom_bar(width = 1, stat = "identity")+ 
  scale_y_reverse()+
  coord_polar("y")+
  ylab("Relative Frequency of Birth")+
  labs(fill='Number of Month in Year')

#create the fourth graph which contains the difference in relative distribution
#use the 'geom_hline' function to include the mean and standard deviation as lines on the graph
ggplot(dataframe2, aes(x=dataframe$Var1, y=dataframe$diff))+
  geom_bar(mapping = aes(x=dataframe$Var1, y=dataframe$diff, fill = dataframe$Var1), stat='summary', fun.y=mean)+
  geom_hline(yintercept = meandiff, colour = "red", lwd = 1)+
  geom_hline(yintercept = meandiff - diffdeviation)+
  geom_hline(yintercept = meandiff + diffdeviation)+
  xlab("Month of Birth")+
  ylab("Difference in Relative Distributions of Births")+
  ggtitle("Difference in Relative Distributions of Births, Wikipedia vs UN Live Births")+
  labs(fill='Number of Month in Year')


#create a bar graph showing the births in the Netherlands per month according to UN data
#import data and organize, assign mean and deviation
livebirths = read.csv('birthsNetherlands.csv', header=FALSE)
livebirths$V1 = c("January" = "Jan","February"="Feb","March" = "Mar","April" = "Apr","May" = "May","June" = "Jun","July" = "Jul","August" = "Aug","September" = "Sep","October" = "Oct","November" = "Nov","December" = "Dec")
meanfreq = mean(livebirths$V2)
deviation = sd(livebirths$V2)
#create the actual plot
ggplot(data = livebirths) +
geom_bar(mapping = aes(x=V1, y=V2), stat = "identity", fill = "black") +
scale_x_discrete(limits = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")) +
geom_hline(yintercept = meanfreq, colour = "red", lwd = 1) +
geom_hline(yintercept = meanfreq - deviation, colour = "grey")+
geom_hline(yintercept = meanfreq + deviation, colour = "grey")+
xlab("Month of Birth") +
ylab("Frequency") +
ggtitle("Amount of Births in the Netherlands per Month as Registered by UN")

#create a bar graph showing the births in Singapore per month according to UN data
#import data and organize, assign mean and deviation
livebirths = read.csv('birthsSingapore.csv', header=FALSE)
livebirths$V1 = c("January" = "Jan","February"="Feb","March" = "Mar","April" = "Apr","May" = "May","June" = "Jun","July" = "Jul","August" = "Aug","September" = "Sep","October" = "Oct","November" = "Nov","December" = "Dec")
meanfreq = mean(livebirths$V2)
deviation = sd(livebirths$V2)
#create the actual plot
ggplot(data = livebirths) +
geom_bar(mapping = aes(x=V1, y=V2), stat = "identity", fill = "black") +
scale_x_discrete(limits = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")) +
geom_hline(yintercept = meanfreq, colour = "red", lwd = 1) +
geom_hline(yintercept = meanfreq - deviation, colour = "grey")+
geom_hline(yintercept = meanfreq + deviation, colour = "grey")+
xlab("Month of Birth") +
ylab("Frequency") +
ggtitle("Amount of Births in Singapore per Month as Registered by UN")

#create a bar graph showing the births in Australia per month according to UN data
#import data and organize, assign mean and deviation
livebirths = read.csv('birthsAustralia.csv', header=FALSE)
livebirths$V1 = c("January" = "Jan","February"="Feb","March" = "Mar","April" = "Apr","May" = "May","June" = "Jun","July" = "Jul","August" = "Aug","September" = "Sep","October" = "Oct","November" = "Nov","December" = "Dec")
meanfreq = mean(livebirths$V2)
deviation = sd(livebirths$V2)
#create the actual plot
ggplot(data = livebirths) +
geom_bar(mapping = aes(x=V1, y=V2), stat = "identity", fill = "black") +
scale_x_discrete(limits = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")) +
geom_hline(yintercept = meanfreq, colour = "red", lwd = 1) +
geom_hline(yintercept = meanfreq - deviation, colour = "grey")+
geom_hline(yintercept = meanfreq + deviation, colour = "grey")+
xlab("Month of Birth") +
ylab("Frequency") +
ggtitle("Amount of Births in Australia per Month as Registered by UN")

# opened under specific names now because they need to be used in relation to each other
aussie = read.csv('birthsAustralia.csv', header=FALSE)
dutch = read.csv('birthsNetherlands.csv', header=FALSE)
sing = read.csv('birthsSingapore.csv', header=FALSE)

# creating relative percentage numbers for comparison
aussie$percent = aussie$V2/sum(aussie$V2)
dutch$percent = dutch$V2/sum(dutch$V2)
sing$percent = sing$V2/sum(sing$V2)

names = c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
months <- aussie$V1
months = dutch$V1
months = sing$V1

dataframe2 = data.frame(cbind(aussie$V2),names,months)
dataframe3 = data.frame(cbind(dutch$V2), names, months)
dataframe4 = data.frame(cbind(sing$V2), names, months)

# Values show difference in relative birth rates by month
aussie$diffdutch = aussie$percent - dutch$percent
aussie$diffsing = aussie$percent - sing$percent
dutch$diffsing = dutch$percent - sing$percent

meandiff.aus.dutch = mean(aussie$diffdutch)
meandiff.aus.sing = mean(aussie$diffsing)
meandiff.dutch.sing = mean(dutch$diffsing)

sd.aus.dutch = sd(aussie$diffdutch)
sd.aus.sing = sd(aussie$diffsing)
sd.dutch.sing = sd(dutch$diffsing)

# Pie charts of births throughout a year
ggplot(dataframe2, aes(x="", y=aussie$V2, fill=months))+
  geom_bar(width = 1, stat = "identity")+ 
  scale_y_reverse()+
  coord_polar("y")+
  ylab("Relative Frequency of Birth")+
  labs(fill='Number of Month in Year')

ggplot(dataframe2, aes(x="", y=dutch$V2, fill=months))+
  geom_bar(width = 1, stat = "identity")+ 
  scale_y_reverse()+
  coord_polar("y")+
  ylab("Relative Frequency of Birth")+
  labs(fill='Number of Month in Year')

ggplot(dataframe2, aes(x="", y=sing$V2, fill=months))+
  geom_bar(width = 1, stat = "identity")+ 
  scale_y_reverse()+
  coord_polar("y")+
  ylab("Relative Frequency of Birth")+
  labs(fill='Number of Month in Year')

# bar graphs noting the differences between relative birth rates

ggplot(dataframe2, aes(x=aussie$V1, y=aussie$diffdutch))+
  geom_bar(mapping = aes(fill = aussie$V1), stat='summary', fun.y=mean)+
  geom_hline(yintercept = meandiff.aus.dutch, colour = "red", lwd = 1)+
  geom_hline(yintercept = meandiff.aus.dutch - sd.aus.dutch)+
  geom_hline(yintercept = meandiff.aus.dutch + sd.aus.dutch)+
  scale_x_discrete(limits = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"))+
  scale_colour_discrete(limits = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"))+
  xlab("Month of Birth")+
  ylab("Difference in Relative Distributions of Births")+
  ggtitle("Difference in Relative Distributions of Births, Australia vs the Netherlands Live Births")+
  labs(fill='Number of Month in Year')


ggplot(dataframe3, aes(x=aussie$V1, y=aussie$diffsing))+
  geom_bar(mapping = aes(fill = aussie$V1), stat='summary', fun.y=mean)+
  geom_hline(yintercept = meandiff.aus.sing, colour = "red", lwd = 1)+
  geom_hline(yintercept = meandiff.aus.sing - sd.aus.sing)+
  geom_hline(yintercept = meandiff.aus.sing + sd.aus.sing)+
  scale_x_discrete(limits = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"))+
  scale_colour_discrete(limits = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"))+
  xlab("Month of Birth")+
  ylab("Difference in Relative Distributions of Births")+
  ggtitle("Difference in Relative Distributions of Births, Australia vs Singapore Live Births")+
  labs(fill='Number of Month in Year')


ggplot(dataframe4, aes(x=dutch$V1, y=dutch$diffsing))+
  geom_bar(mapping = aes(fill = dutch$V1), stat='summary', fun.y=mean)+
  geom_hline(yintercept = meandiff.dutch.sing, colour = "red", lwd = 1)+
  geom_hline(yintercept = meandiff.dutch.sing - sd.dutch.sing)+
  geom_hline(yintercept = meandiff.dutch.sing + sd.dutch.sing)+
  scale_x_discrete(limits = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"))+
  scale_colour_discrete(limits = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"))+
  xlab("Month of Birth")+
  ylab("Difference in Relative Distributions of Births")+
  ggtitle("Difference in Relative Distributions of Births, the Netherlands vs Singapore Live Births")+
  labs(fill='Number of Month in Year')

#creating a plot showing the amount of births on specific DAYS using the wikipedia data
#read in the csv file and determine mean and standard deviation
bdays = read.csv('birthdates.csv', header=FALSE)
dataframe <- as.data.frame(table(bdays))
meanfreq = mean(dataframe$Freq)
deviation = sd(dataframe$Freq)
names = c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
dates <- dataframe$V1
dataframe2 = data.frame(cbind(dataframe$Freq),names,dates)
#create the actual plot
ggplot(dataframe2, aes(names, dataframe$Freq)) +   
geom_bar(aes(fill = dates), position = "dodge", stat="identity") + scale_x_discrete(limits=names) +
geom_hline(yintercept = meanfreq, colour = "red", lwd = 1) +
geom_hline(yintercept = meanfreq - deviation, colour = "grey")+
geom_hline(yintercept = meanfreq + deviation, colour = "grey")+
xlab("Month of Birth") +
ylab("Frequency") +
ggtitle("Frequency of Births per Day as Registered on Wikipedia") +
labs(fill='Day number in Month')

#create stargazer tables for the latex file:
install.packages("stargazer")
library("stargazer")
stargazer(reallife)
stargazer(days$months)
