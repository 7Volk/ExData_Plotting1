# Loads household power consumption data from the given path.
loadData  <- function(path) {
  data  <- read.csv(path, sep=";", na.strings="?")
  data$Date <- as.Date(data$Date, format="%d/%m/%Y")
  data  <- data[(data$Date=="2007-02-01" | data$Date=="2007-02-02"),]
  
  ## Converting dates
  datetime <- paste(as.Date(data$Date), data$Time)
  data$Datetime <- as.POSIXct(datetime)
  data
}

plot4  <- function(data, png.filename) {
  ## Plot 4
  par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
  with(data, {
    plot(Global_active_power~Datetime, type="l", 
         ylab="Global Active Power", xlab="")
    plot(Voltage~Datetime, type="l", 
         ylab="Voltage", xlab="")
    plot(Sub_metering_1~Datetime, type="l", 
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Datetime, type="l", 
         ylab="Global Reactive Power",xlab="")
  })
  ## Save to png file
  dev.copy(png, file=png.filename, height=480, width=480)
  dev.off()  
}

data  <- loadData("household_power_consumption.txt")
plot4(data, "plot4.png")
