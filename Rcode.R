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

