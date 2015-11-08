# Plot 4.r

# Use Data.Table Library for quickly loading data into R.
library(data.table)
library(lubridate)

# Create Column Names for reading in the datatable
columnnames = c("Date", "Time", "Global_active_power",
                "Global_reactive_power", "Voltage",
                "Global_intensity","Sub_metering_1",
                "Sub_metering_2","Sub_metering_3")

# Read Data Table from Associated Text File
dat <- fread("exdata-data-household_power_consumption/household_power_consumption.txt",
             sep = ";", col.names = columnnames,
             na.strings = "?")

# Create a subset for data from 2007-02-01 and 2007-02-02
specificdata <- subset(dat, dat$Date == "1/2/2007" | dat$Date == "2/2/2007")

# Coerce dates into Date objects
#specificdata$Date <- as.Date(specificdata$Date, "%d/%m/%Y")
DateTime <- paste(specificdata$Date,specificdata$Time)
DateTime <- strptime(DateTime,"%d/%m/%Y %H:%M:%S")

# Open a PNG file device with specified dimensions
png(file = "plot4.png",width = 480, height = 480)

# Organize figure to be a 2x2 grid of plots
par(mfrow = c(2,2))

# Plot Global active power vs. day of week
plot(DateTime, specificdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# Plot Voltage vs. day of the week
plot(DateTime, specificdata$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Plot the data as a line plot, and add appropriate labels
plot(DateTime, specificdata$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(DateTime, specificdata$Sub_metering_2, col = "red")
lines(DateTime, specificdata$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot Global_reactive_power vs. day of the week
plot(DateTime, specificdata$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# Turn off File Device
dev.off()
