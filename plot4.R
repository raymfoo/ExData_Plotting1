# ==================================================
# Plot 4.R
# Created by : Raymond Foo
# Created on : 2015-11-07
# ==================================================


# This function loads the electrical poweer consumption date from file.
# Date and time are formatted as date and datetime in the fDate and fTime column respectively.
# Date is subsetted to be between 2007-02-01 and 2007-02-02 inclusively.
loadData <- function(){
  
  #Date boundaries
  fromDate <- as.Date("2007-02-01", "%Y-%m-%d")
  toDate <- as.Date("2007-02-02", "%Y-%m-%d")
  
  electricData <- read.csv("household_power_consumption.txt", header=T, sep = ";", na.strings = "?")
  electricData$fDate <- as.Date(electricData$Date,"%d/%m/%Y")
  electricData <- electricData[electricData$fDate>=fromDate & electricData$fDate<=toDate, ]
  electricData$fTime <- strptime(paste(electricData$Date,electricData$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
  electricData
}


#This function draws the graph and export as plot4.png
generateGraph <- function(){
  png(filename = "plot4.png")
  par(cex=0.75)
  par(bg="white")
  par(mfrow=c(2,2))
  
  #Plot 1
  with(electricData, plot(fTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = NA))
  
  #Plot 2
  with(electricData, plot(fTime, Voltage, type = "l", xlab = "datetime"))
  
  #Plot 3
  with(electricData, plot(fTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = NA))
  with(electricData, lines(fTime, Sub_metering_2, col = "red"))
  with(electricData, lines(fTime, Sub_metering_3, col = "blue"))
  legend("topright", lty = c(1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), bty="n")
  
  #Plot 4
  with(electricData, plot(fTime, Global_reactive_power, type = "l", xlab = "datetime"))
  dev.off()
}


#run functions
electricData<-loadData()
generateGraph()