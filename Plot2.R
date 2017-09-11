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
png(file="Plot2.png", width=480, height=480, units="px")
plot(FebData$DatenTime,FebData$Global_active_power,type="n",xlab="", ylab="Global Active Power (Kilowatts)")
lines(FebData$DatenTime,FebData$Global_active_power)
dev.off()