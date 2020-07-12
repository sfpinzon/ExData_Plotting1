library(dplyr)
library(lubridate)
setwd("~/R/Coursera/Exploratory data analysis/ExData_Plotting1/ExData_Plotting1")
#Import data
df=read.table("household_power_consumption.txt", header=TRUE, sep=";")
#Transform to tibble
data=as_tibble(df)
#Transform date column to correct format
data$Date=as.Date(data$Date, format = "%d/%m/%Y")
#Subset data to correct dates
data=filter(data, Date<="2007-02-02" & Date>="2007-02-01")
#Change time format
#data$Time=sub(".*\\s+","",strptime(data$Time, "%H:%M:%S"))
data$Time=as_hms(strptime(data$Time, "%H:%M:%S"))
#Transform rest of columns to numeric format
data[,3:9]=data%>%select(-c("Date","Time"))%>%lapply(as.numeric)%>%as_tibble()
datetime=ymd_hms(paste(data$Date,data$Time))

png(filename = "plot4.png")

par(mfrow=c(2,2))
plot(datetime,data$Global_active_power/1000, type='l', ylab='Global Active Power',
     xlab='')
plot(datetime,data$Voltage, type='l', ylab='Voltage',
     xlab='datetime')
plot(datetime, data$Sub_metering_1,type='n', ylab='Energy sub metering', 
     xlab='', )
lines(datetime, data$Sub_metering_1, col='black')
lines(datetime, data$Sub_metering_2, col='red')
lines(datetime, data$Sub_metering_3, col='blue')
legend("topright", legend=colnames(data[,7:9]), lty=1, col=c('black', 'red', 'blue'))
plot(datetime, data$Global_reactive_power,type='l', ylab='Global Reactive Power', 
     xlab='datetime', )
dev.off()