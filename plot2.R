## load dplyr, we'll need it
library(dplyr)

## read entire data, wasnt able to load part of it with read.csv.sql

df_raw <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

## convert Date variable to Date class
df_raw$Date <- as.Date(df_raw$Date, format = "%d/%m/%Y" ) 

## subset only necessary dates
df <- filter(df_raw, Date >= "2007-02-01" & Date <= "2007-02-02")

#remove entire data, so it dont allocate memory
rm(df_raw)

## merge date and time into single column and change it type to POSIX
df<-mutate(df, date_time = as.POSIXct(paste(df$Date, df$Time)))

## plot 2
plot(df$Global_active_power~df$date_time, type="l", main = "", xlab="", ylab="Global Active Power (kilowatts)")

##save to file
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()