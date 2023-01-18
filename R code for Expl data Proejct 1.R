
## Plot1.R 

setwd("~/Desktop/r_test/directoryName")
data<-read.csv("household_power_consumption.csv", header=T, sep=';', na.strings="?", stringsAsFactors=F,dec=".")
data1 <-subset(data, Date %in% c("1/2/2007","2/2/2007"))
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
hist(data1$Global_active_power, main="Global Active Power", 
       +      xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
png("plot1.png", width=480, height=480)
dev.off()

## Plot2.R

setwd("~/Desktop/r_test/directoryName")
data <- read.csv("household_power_consumption.csv", header=T, sep=';', na.strings="?", stringsAsFactors=F,dec=".")
data1 <-subset(data, Date %in% c("1/2/2007","2/2/2007"))
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
data1$datetime <- paste(data1$Date, data1$Time)
data1$datetime <- as.POSIXct(data1$datetime)

##Plotting

plot(data1$Global_active_power~data1$datetime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()


## Plot3.R

setwd("~/Desktop/r_test/directoryName")
data <- read.csv("household_power_consumption.csv", header=T, sep=';', na.strings="?", stringsAsFactors=F,dec=".")
data1 <-subset(data, Date %in% c("1/2/2007","2/2/2007"))
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
data1$datetime <- paste(data1$Date, data1$Time)
data1$datetime <- as.POSIXct(data1$datetime)

##plotting data
png("plot3.png", width=480, height=480)
with(data1,{
  plot(data1$Sub_metering_1~data1$datetime, type="l",ylab="Energy sub metering", xlab="")
  lines(data1$Sub_metering_2~data1$datetime,col='Red')
  lines(data1$Sub_metering_3~data1$datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

##Plot 4.R

setwd("~/Desktop/r_test/directoryName")
data <- read.csv("household_power_consumption.csv", header=T, sep=';', na.strings="?", stringsAsFactors=F,dec=".")
data1 <-subset(data, Date %in% c("1/2/2007","2/2/2007"))
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
data1$datetime <- paste(data1$Date, data1$Time)
data1$datetime <- as.POSIXct(data1$datetime)

with(data1,{
  plot(data1$Sub_metering_1~data1$datetime, type="l",ylab="Energy sub metering", xlab="")
  lines(data1$Sub_metering_2~data1$datetime,col='Red')
  lines(data1$Sub_metering_3~data1$datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(data1$Global_reactive_power~data1$datetime, type="l",ylab="Global_reactive_power", xlab="datetime")

dev.off()
