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

## plot 4
## in this case we need to open png for plot BEFORE we create a plot, otherwise
## when we create and resize plot, legend will be cut by half, thus losing any sence
png(file = "plot4.png", width = 480, height = 480)

## initialize the 2x2 images plot
par(mfrow = c(2,2),mar=c(4,4,2,1),oma=c(0,0,2,0))
with(df,{
  ## 1st plot
  plot(Global_active_power~date_time, type="l", main = "", xlab="", ylab="Global Active Power")
  ## 2nd plot
  plot(Voltage~date_time, type="l", main = "", xlab="datetime", ylab="Voltage")
  ## 3rd plot
  plot(Sub_metering_1~date_time, type="l", main = "", xlab="", ylab="Energy sub metering")
  lines(Sub_metering_2~date_time, col="Red")
  lines(Sub_metering_3~date_time, col="Blue")
  legend("topright", col=c("black", "red","blue"),lty=1,lwd=2,
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  ##4th plot
  plot(Global_reactive_power~date_time, type="l", main = "", xlab="datetime", ylab="Global_reactive_power")
  
})
dev.off()