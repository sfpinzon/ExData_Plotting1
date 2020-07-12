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

png(filename = "plot1.png")
hist(data$Global_active_power/1000, main= "Global Active Power",xlab="Global Active Power (kilowatts)", 
     col='red')
dev.off()
