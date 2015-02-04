# load library data.table for clean .txt import
library(data.table)
data <- read.table("household_power_consumption.txt", header=TRUE, sep=';', nrows=2075259, na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

# convert date and parse back into same property
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# subset date range
dataNew <- subset(data, subset=(Date >= '2007-02-01' & Date <= '2007-02-02'))

# create time vector of class character
datetime <- paste(as.Date(dataNew$Date), dataNew$Time)

# append datetime as new column
dataNew$Datetime <- as.POSIXct(datetime)

# open printing device
png(filename='plot1.png', height=480, width=480)

# plot histogram
hist(dataNew$Global_active_power, col="Red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")

# close priting device
dev.off()
