
## This macro reads in a subset of lines from household power
## consumption dataset and makes plot2.png.

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

## Make plot2.png
png(file="plot2.png", width=480, height=480, bg="transparent")
par(mar = c(5, 4, 4, 2)+0.1)
plot(subHP$Datime, subHP$Global_active_power, type="l",
     main="", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

