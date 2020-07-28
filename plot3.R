library(lubridate)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dbzipfile <- "database.zip"
dbfile <- "household_power_consumption.txt"


if (!file.exists(dbzipfile)) {
  download.file(url, dbzipfile, method="curl")
  unzip(dbzipfile)
}

## setup sql query
sql_filter <- "select * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007' "
source("read_subset.R")

dt <- read_subset_data(dbfile, sql_filter)
## Add a new column to combine date and time
dt$datetime <- with(dt, strptime(paste(Date,Time, sep=" "), "%d/%m/%Y %H:%M:%S"))

plot (dt$datetime, dt$Sub_metering_1, type="l",
      ylab="Energy sub metering",
      xlab = " ")
lines (dt$datetime, dt$Sub_metering_2, type="l", col="red")
lines (dt$datetime, dt$Sub_metering_3, type="l", col="blue")

legend("topright", 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       pch="-")


dev.copy(png, file = "plot3.png")
dev.off()
