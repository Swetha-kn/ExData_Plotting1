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

#plotting plot2 line graph
par(mfrow=c(1,1))
plot(EPC_DT$dateTime,EPC_DT$Global_active_power,type = "l",xlab = "",ylab = "Global Active Power (Kilowatts)")

#send file to plot2.png file
dev.copy(png,file= "plot2.png",width=480, height= 480)
dev.off()
