# ==================================================
# Plot 1.R
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


#This function draws the graph and export as plot1.png
generateGraph <- function(){
  par(cex=0.75)
  par(mar=c(5.1,6.1,4.1,2.1))
  hist(electricData$Global_active_power, main = "Global Active Power", xlab = "Global Active Power(kilowatts)", col = "red")  
  dev.copy(png, file = "plot1.png")
  dev.off()
}


#run functions
electricData<-loadData()
generateGraph()