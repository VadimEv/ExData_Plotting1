## load dplyr and lubridate, we'll need it

library(dplyr)
library(lubridate)

## read entire data, wasnt able to load part of it with read.csv.sql

df_raw <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

## convert Date variable to Date class
df_raw$Date <- as.Date(df_raw$Date, format = "%d/%m/%Y" ) 

## subset only necessary dates
df <- filter(df_raw, Date >= "2007-02-01" & Date <= "2007-02-02")

#remove entire data, so it dont allocate memory
rm(df_raw)

## convert Time
df$Time <- hms(df$Time)

## Plot1 - histogram
hist(df$Global_active_power, main = "Global Active Power", xlab ="Global Active Power (kilowatts)",
     ylab = "Frequency", col="Red")

##save to file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()