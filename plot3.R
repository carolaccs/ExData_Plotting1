## Exploratory Data Analysis: Week 1: Project
### plot2.R
#### Ivette Carolina Martinez

#### 1. Loading Libraries
library(dplyr)

#### 2. Getting Data
dataSetUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("./data/exdata-data-household_power_consumption.zip")){
  download.file(dataSetUrl, destfile= "./data/exdata-data-household_power_consumption.zip", method = "curl")
  dateDownloaded <- date()
}
if (!file.exists("./data/household_power_consumption.txt")){
  unzip(zipfile="./data/exdata-data-household_power_consumption.zip",exdir="./data/")
}

#### 3. Reading Data 
powerConsumptionDF <- read.table("./data/household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?")
powerConsumptionDF$Date <- as.Date(powerConsumptionDF$Date, format="%d/%m/%Y")
powerConsumptionDF <- filter(powerConsumptionDF, Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02"))


### Creating and formating dateTime sequence, transforming dateTime using as.POSIXct
dateTime <-  paste(as.Date(powerConsumptionDF$Date), powerConsumptionDF$Time, sep= " ")
dateTime <- as.POSIXct(dateTime)


#### 4. Generating plots
plot(dateTime, powerConsumptionDF$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(dateTime, powerConsumptionDF$Sub_metering_2, type="l", xlab="", col='red')
lines(dateTime, powerConsumptionDF$Sub_metering_3, type="l", xlab="", col='blue')
legend("topright", 
       col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       pt.cex=1, cex=0.5,lty=1, y.intersp=1)
       


#### 5. Saving png
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()

