library(dplyr)
library(lubridate)
# read in all the data as a dataframe
AllData<- read.table("household_power_consumption.txt",sep=";",header=TRUE, stringsAsFactors = FALSE)
#create a new column based on the value of the current text date and time
AllData$DatenTime <- strptime(paste(AllData$Date,AllData$Time), format="%d/%m/%Y %H:%M:%S")
# extract the rows with their date on 2007-02-01 or 2007-02-02
FebData <-AllData[ year(AllData$DatenTime)==2007 & month(AllData$DatenTime)==2&
                     (day(AllData$DatenTime)==1|day(AllData$DatenTime)==2),]
FebData$Global_active_power <- as.numeric(FebData$Global_active_power)
FebData$Global_reactive_power <- as.numeric(FebData$Global_reactive_power)
FebData$Voltage <- as.numeric(FebData$Voltage)
FebData$Sub_metering_1 <- as.numeric(FebData$Sub_metering_1)
FebData$Sub_metering_2 <- as.numeric(FebData$Sub_metering_2)
png(file="Plot4.png", width=480, height=480, units="px")

par(mfrow=c(2,2))

plot(FebData$DatenTime,FebData$Global_active_power,type="n",xlab="", ylab="Global Active Power (Kilowatts)")
lines(FebData$DatenTime,FebData$Global_active_power)

plot(FebData$DatenTime,FebData$Voltage,type="n",ylab="voltage",xlab="datetime")
lines(FebData$DatenTime,FebData$Voltage)

plot(FebData$DatenTime,FebData$Sub_metering_1,type="n",xlab="", ylab="Energy sub metering")
lines(FebData$DatenTime,FebData$Sub_metering_1,col="black")
lines(FebData$DatenTime,FebData$Sub_metering_2,col="red")
lines(FebData$DatenTime,FebData$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),legend=c(names(FebData)[7:9]),lwd=1,cex=0.5)

plot(FebData$DatenTime,FebData$Global_reactive_power,type="n",xlab="datetime", ylab="Global Reactive Power (Kilowatts)")
lines(FebData$DatenTime,FebData$Global_reactive_power)

dev.off()