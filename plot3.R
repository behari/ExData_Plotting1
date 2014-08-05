
## This macro reads in a subset of lines from household power
## consumption dataset and makes plot3.png.

## Read in lines corresponding to the days of interest using sqldf package
library(sqldf)
f <- file("household_power_consumption.txt")
subHP <- sqldf("select * from f where Date in ('1/2/2007', '2/2/2007')",
               dbname=tempfile(), stringsAsFactors=FALSE,
               file.format = list(sep=";", header=TRUE, row.names=FALSE))
close(f)

## Replace the char Date column w/ Date class
subHP$Date <- as.Date(subHP$Date,"%d/%m/%Y")
## Create a new column w/ the Date/Time class
subHP$Datime <- strptime(paste(subHP$Date,subHP$Time),
                         format="%Y-%m-%d %H:%M:%S")

## Make plot3.png
png(file="plot3.png", width=480, height=480, bg="transparent")
par(mar = c(5, 4, 4, 2)+0.1)
plot(subHP$Datime, subHP$Sub_metering_1, type="l", col=1,
     main="", xlab="", ylab="Energy sub metering")
lines(subHP$Datime, subHP$Sub_metering_2, type="l", col=2)
lines(subHP$Datime, subHP$Sub_metering_3, type="l", col=4)
legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1, col=c(1,2,4))
dev.off()

