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

par(mfrow=c(2,2))


##### (1,1) Plot: Global Active Power
plot(powerConsumptionDF$Global_active_power~dateTime,type="l", 
     xlab="", ylab="Global Active Power")

##### (1,2) Plot: Voltage
plot(dateTime, powerConsumptionDF$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

##### (2,1) Plot: Energy Submetering
plot(dateTime, powerConsumptionDF$Sub_metering_1, type="l", xlab="", ylab="Energy Submetering")
lines(dateTime, powerConsumptionDF$Sub_metering_2, type="l", xlab="", col='red')
lines(dateTime, powerConsumptionDF$Sub_metering_3, type="l", xlab="", col='blue')
legend("topright", 
       col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1, bty = "n")

##### (2,2) Plot: Global Reactive Power
plot(dateTime, powerConsumptionDF$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")




#### 5. Saving png
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()

