# Exploratory Data Analysis - Course Project 1 - plot3.R

# assume data file is in working directory
# load it into a variable
# first read 5 rows to determine column classes - this speeds up the load
#tab5rows <- read.table("household_power_consumption.txt", header = TRUE, nrows = 5, sep = ";", na.strings="?")
#classes <- sapply(tab5rows, class)
#allData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?", colClasses=classes)
allData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?",stringsAsFactors=FALSE)

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

# construct the plot
#plot(targetData$DateTime,targetData$Global_active_power, xlab="",ylab="Global Active Power (kilowatts)", type="l")
plot(targetData$DateTime,targetData$Sub_metering_1,type="n", xlab="", ylab="Energy Sub Metering", col="black",ylim=c(0,30))
lines(targetData$DateTime,targetData$Sub_metering_2,col="red")
lines(targetData$DateTime,targetData$Sub_metering_3,col="blue")
legend("topright", lty=c(1,1,1), col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

dev.copy(png,'plot3.png')
dev.off()