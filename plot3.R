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
png(filename='plot3.png', height=480, width=480)

# plot line graph
with(dataNew, {
plot(Sub_metering_1~Datetime, type='l',  xlab='', ylab='Global Active Power (kilowatts)')
lines(Sub_metering_2~Datetime, col='Red')
lines(Sub_metering_3~Datetime, col='Blue')
})
legend(col=c('black','red','blue'), lty=1, lwd=2, legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 'topright')

# close priting device
dev.off()
