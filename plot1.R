# Plot 1.r

# Use Data.Table Library for quickly loading data into R.
library(data.table)

# Create Column Names for reading in the datatable
columnnames = c("Date", "Time", "Global_active_power",
                "Global_reactive_power", "Voltage",
                "Global_intensity","Sub_metering_1",
                "Sub_metering_2","Sub_metering_3")

# Read Data Table from Associated Text File
dat <- fread("exdata-data-household_power_consumption/household_power_consumption.txt",
             sep = ";", col.names = columnnames,
             na.strings = "?"
)

# Create a subset for data from 2007-02-01 and 2007-02-02
specificdata <- subset(dat, dat$Date == "1/2/2007" | dat$Date == "2/2/2007")

# Plot the data as a histogram, change color and add appropriate labels
with(specificdata, hist(Global_active_power, main = "Global Active Power",
                        xlab = "Global Active Power (kilowatts)",
                        col = "red"))

# Output current graphics display to a png device, then close the device
dev.copy(png, file = "plot1.png", width = 480, height = 480) ## Copy my plot to a PNG file
dev.off() ## Don't forget to close the PNG device!
