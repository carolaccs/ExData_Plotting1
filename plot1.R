## Exploratory Data Analysis: Week 1: Project
### Ivette Carolina Martinez

#### 1. Loading Libraries
library(dplyr)

#### 2. Getting Data
dataSetUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists(".data/exdata-data-household_power_consumption.zip")){
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

#### 4. Generating Histogram 
hist(powerConsumptionDF$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

#### 5. Saving png
dev.copy(png,"plot1.png", width=500, height=500)
dev.off()
