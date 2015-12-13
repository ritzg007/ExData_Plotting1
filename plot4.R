

par(mfcol=c(2,2),mar=c(2,4,0,1), oma=c(0,0,0,0))

## package in order to use sql in read.csv

library(sqldf)
data<-read.csv.sql("household_power_consumption.txt", sql="select * from file 
                   where Date='1/2/2007' or Date='2/2/2007' ", header=TRUE, sep=";")


##combining date and time and changing it to R datetime
NewTime<-paste(as.Date(data$Date,"%d/%m/%Y"),data$Time)
data$NewTime<-as.POSIXlt(NewTime)
s<-sort(data$NewTime)


with(data,{plot(s,data$Global_active_power,type="l",pch='.',
     ylab="Global Active Power(kilowatts)",xlab=" ")

plot(s,data$Sub_metering_1,type="n",
     ylab="Energy Sub Metering",xlab=" ")
points(s,data$Sub_metering_1,type="l",pch='-')
points(s,data$Sub_metering_2,type="l",pch='-',col="red")
points(s,data$Sub_metering_3,type="l",pch='-',col="blue")
legend("topright",pch='l',col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(s,data$Voltage,type="l",pch='.', 
     ylab="Voltage (volt)", xlab="DateTime")


plot(s,data$Global_reactive_power,type="l",pch='.', 
     ylab="Global Reactive Power(kilowats)", xlab="DateTime")


##copying the output of base plot to a png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()


})

