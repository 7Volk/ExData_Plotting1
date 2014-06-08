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

plot3  <- function(data, png.filename) {
  ## Plot 3
  with(data, {
    plot(Sub_metering_1~Datetime, type="l",
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
  })
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  ## Save to png file
  dev.copy(png, file=png.filename, height=480, width=480)
  dev.off()  
}

data  <- loadData("household_power_consumption.txt")
plot3(data, "plot3.png")
