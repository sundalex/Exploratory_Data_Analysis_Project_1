# Plot 2.r

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


# Plot the data as a line plot, and add appropriate labels
plot(DateTime, specificdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Output current graphics display to a png device, then close the device
dev.copy(png, file = "plot2.png", width = 480, height = 480) ## Copy my plot to a PNG file

# Turn off file device
dev.off()
