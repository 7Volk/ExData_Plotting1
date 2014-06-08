# Loads household power consumption data from the given path.
loadData  <- function(path) {
  data  <- read.csv(path, sep=";", na.strings="?")
  data$Date <- as.Date(data$Date, format="%d/%m/%Y")
  data <- subset(data, (Date >= "2007-02-01" & Date <= "2007-02-02"))
  ## Converting dates
  datetime <- paste(as.Date(data$Date), data$Time)
  data$Datetime <- as.POSIXct(datetime)
  data
}

plot1  <- function(data, png.filename) {
  ## Plot 1
  hist(data$Global_active_power, main="Global Active Power", 
       xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
  
  ## Save to png file
  dev.copy(png, file=png.filename, height=480, width=480)
  dev.off()  
}

data  <- loadData("household_power_consumption.txt")
plot1(data, "plot1.png")
