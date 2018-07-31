###############################################################################
# Descritpion: Load and clean the ExDAta_Plotting data to create graphs
# Author: Swetha. Kn
# Date: 07- 30- 2018
##############################################################################
#Download and Reading data
setwd("/Users/sandeepkrishnamurthy/Documents/swetha/Learning/Data_Science/ExData_Plotting1")
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
con <- unz(temp,"household_power_consumption.txt")
EPC_data <- read.table(con,header = TRUE,sep = ";",na.strings = "?",stringsAsFactors=FALSE,colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
unlink(temp)

#Fetch data for only "1/2/2007" and "2/2/2007" days
EPC_DT <- EPC_data[EPC_data$Date %in% c("1/2/2007","2/2/2007") ,]

## Combine Date and Time column and convert to POSIXct format
dateTime <- paste(EPC_DT$Date, EPC_DT$Time)
dateTime <- setNames(dateTime, "DateTime")
EPC_DT <- cbind(dateTime,EPC_DT)
EPC_DT$dateTime <- strptime(EPC_DT$dateTime, "%d/%m/%Y %H:%M:%S") 
EPC_DT$dateTime <- as.POSIXct(EPC_DT$dateTime)

#plotting plo4 with multiple graphs
par(mfrow=c(2,2),mar=c(4,4,2,1), oma=c(0,0,2,0))
with(EPC_DT,{
        plot(Global_active_power~dateTime,type = "l",xlab = "",ylab = "Global Active Power (Kilowatts)")
        plot(Voltage~dateTime,type = "l",xlab = "",ylab = "Voltage")
        plot(Sub_metering_1~dateTime, type="l", ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~dateTime,col='Red')
        lines(Sub_metering_3~dateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"),lty=1, lwd = 1,bty = "n",xjust = 1,
               x.intersp = 0.35, y.intersp = 0.45,
               c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~dateTime,type = "l",xlab = "",ylab = "Global_reactive_power")
})

#send file to plot4.png file
dev.copy(png,file= "plot4.png",width=480, height= 480)
dev.off()