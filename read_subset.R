## This function assumes an ordered dataset, ordered on col
## reads file with following format
## $ head household_power_consumption.txt 
## Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
## 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000
## 16/12/2006;17:25:00;5.360;0.436;233.630;23.000;0.000;1.000;16.000
## 16/12/2006;17:26:00;5.374;0.498;233.290;23.000;0.000;2.000;17.000
## sql_filter <- "select * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007' "
read_subset_data <- function(file, sql_filter, header = TRUE, sep = ";") {
  
  dt <- read.csv.sql(file, sql_filter,
                     header = TRUE,
                     sep = ";")
  ## read.csv.sql issues a warning after some time 'closing unused connection..."
  ## right way to close this one connection is to use base::close but it requires
  ## string manipulation to change the query to remove 'file' from it.
  ## Using a brute force approach instead.
  base::closeAllConnections()
  return (dt)
}
