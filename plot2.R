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

plot2  <- function(data, png.filename) {
  ## Plot 2
  plot(data$Global_active_power~data$Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  
  ## Save to png file
  dev.copy(png, file=png.filename, height=480, width=480)
  dev.off()  
}

data  <- loadData("household_power_consumption.txt")
plot2(data, "plot2.png")
