install.packages("R.utils")
library(R.utils)
install.packages("lubridate")
library(lubridate)
install.packages("tidyr")
library("tidyr")

#creates file
filename <- "household_power_consumption.zip"

#if filename above does not exist, then downloads the file to filename
if (!file.exists(filename)){
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url, filename, method = "curl")
}

#if household_power_consumption dataset does not exist, unzip the files in filename to this directory
if (!file.exists("household_power_consumption")){
        unzip(filename)
}

# reads in power plant data
power_plant_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", encoding = "UTF8", colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'))

#subset of data for dates 2007-02-01 and 2007-02-02.
power_plant_subset <- power_plant_data[ which(power_plant_data$Date == "1/2/2007" | power_plant_data$Date == "2/2/2007"),]

#Makes into POSIX ready format and makes into POSIX object
#changing 'Date' into date data
power_plant_subset$Date <- as.Date(power_plant_subset$Date, "%d/%m/%Y")
power_plant_subset <- unite(power_plant_subset, "date_time", "Date", "Time", sep = " ", remove = TRUE)
power_plant_subset$date_time <- as.POSIXct(power_plant_subset$date_time, format = "%Y-%m-%d %H:%M:%S")

#creates Graphics Devices, Plots and turns device off for plot2.png
png(file = "plot2.png", width = 480, height = 480)
with(power_plant_subset, plot(Global_active_power ~ date_time, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()
