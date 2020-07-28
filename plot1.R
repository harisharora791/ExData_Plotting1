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

hist(dt$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()


