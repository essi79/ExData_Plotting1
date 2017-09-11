library(dplyr)
library(lubridate)
# read in all the data as a dataframe
AllData<- read.table("household_power_consumption.txt",sep=";",header=TRUE, stringsAsFactors = FALSE)
#create a new column based on the value of the current text date and time
AllData$DatenTime <- strptime(paste(AllData$Date,AllData$Time), format="%d/%m/%Y %H:%M:%S")
# extract the rows with their date on 2007-02-01 or 2007-02-02
FebData <-AllData[ year(AllData$DatenTime)==2007 & month(AllData$DatenTime)==2&
                     (day(AllData$DatenTime)==1|day(AllData$DatenTime)==2),]
FebData$Sub_metering_1 <- as.numeric(FebData$Sub_metering_1)
FebData$Sub_metering_2 <- as.numeric(FebData$Sub_metering_2)

png(file="Plot3.png", width=480, height=480, units="px")
plot(FebData$DatenTime,FebData$Sub_metering_1,type="n",xlab="", ylab="Energy sub metering")
lines(FebData$DatenTime,FebData$Sub_metering_1,col="black")
lines(FebData$DatenTime,FebData$Sub_metering_2,col="red")
lines(FebData$DatenTime,FebData$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),legend=c(names(FebData)[7:9]),lwd=1,cex=0.5)
dev.off()