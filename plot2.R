# ==================================================
# Plot 2.R
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


#This function draws the graph and export as plot2.png
generateGraph <- function(){
  par(cex=0.75)
  par(bg=NA)
  with(electricData, plot(fTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = NA))
  dev.copy(png, file = "plot2.png")
  dev.off()
}


#run functions
electricData<-loadData()
generateGraph()