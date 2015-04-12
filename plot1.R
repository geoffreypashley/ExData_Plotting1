# Exploratory Data Analysis - Course Project 1 - plot1.R

# assume data file is in working directory
# load it into a variable
# first read 5 rows to determine column classes - this speeds up the load
tab5rows <- read.table("household_power_consumption.txt", header = TRUE, nrows = 5, sep = ";", na.strings="?")
classes <- sapply(tab5rows, class)
allData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?", colClasses=classes)

# subset the data - only look for 2/1/2007 or 2/2/2007 - just use as text.
# leading 0 in date (02/01/2007 vs 2/1/2007 threw me off)
targetData <- allData[allData$Date == "2/1/2007" | allData$Date == "2/2/2007",]
# lighten the load
rm(allData)

# add a column that combines the Date and Time columns so I can
# subsequently convert that column to time using strptime()
# something like this:
Dt_Time <- as.POSIXct(paste(targetData$Date, targetData$Time), format="%m/%d/%Y %H:%M:%S")
targetData[,"DateTime"] <- Dt_Time
#targetData[,"Global_active_power"] <- as.numeric(targetData$Global_active_power)
hist(targetData$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.copy(png,'plot1.png')
dev.off()

