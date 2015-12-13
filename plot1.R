
## package in order to use sql in read.csv
library(sqldf)


data<-read.csv.sql("household_power_consumption.txt", sql="select * from file 
                   where Date='1/2/2007' or Date='2/2/2007' ", header=TRUE, sep=";")

##combining date and time and changing it to R datetime

NewTime<-paste(as.Date(data$Date,"%d/%m/%Y"),data$Time)
data$NewTime<-as.POSIXlt(NewTime)
s<-sort(data$NewTime)

##sending the output of hist to a png file
png(file="plot1.png", height=480, width=480)
hist(data$Global_active_power,col="red",xlab="Global Active Power(kilowatts)",
     main="Global Active Power")
dev.off()
