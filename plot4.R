# Downloading the data set using R: 
# 1.    Assign the url of the data set to an object called dataset_url.
# 2.    download the file to the working directory using download.file function
# 3.    unzip the file to the working directory using unzip function
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(dataset_url, destfile = "exdata_data_household_power_consumption.zip")

unzip("exdata_data_household_power_consumption.zip")

# Extracting "selected" data set from the CSV file using "sqldf" package.
# 1.    install the sqldf package using install.packages("sqldf) if the sqldf package was not istalled previously.
# 2.    load the package using library function using library function.
# 5.    if the current package is RSQLite is version 1.0.0 then there is a need to use a source file to fix a bug related to the compatibility issues.
# 3.    Read the csv file in the working directory using read.csv.sql, and select the data belong two days using sql "SELECT".
# 4.    close the connection to sql using closeAllConnections function.


library(sqldf)

source("http://sqldf.googlecode.com/svn/trunk/R/sqldf.R")

data <- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file WHERE Date IN ('1/2/2007', '2/2/2007')", sep = ";", header = TRUE)

closeAllConnections()

# create a new column which combines Date and Time columns and then convert into POSIXlt format.

data$DT <- strptime(paste(data$Date, data$Time, sep=","), format="%d/%m/%Y,%H:%M:%S")

# plot4 stored as a function, which used plot function (four times) to produce a panle of 4 plots.

plot4 <- function() {
        par(mfrow = c(2,2), mar = c(4.0, 4.0, 2.0, 2.0))
        
        with (data, {
                
                plot(data$DT, data$Global_active_power, type = "l", main = "Golabl Active Power", 
                     xlab = "", ylab = "Global Active Power (kilowatts)")
                
                plot(data$DT, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
                
                plot(data$DT, data$Sub_metering_1 + data$Sub_metering_2 + data$Sub_metering_3, 
                     type = "l", xlab = "", ylab = "Energy sub metering")
                lines(data$DT, data$Sub_metering_1, col = "black")
                lines(data$DT, data$Sub_metering_2, col = "red")
                lines(data$DT, data$Sub_metering_3, col = "blue")
                legend("topright", lty = 1, lwd = 2, col = c("black", "red", "blue"), 
                       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 0.8)
                
                
                plot(data$DT, data$Global_reactive_power, type = "l", 
                     xlab = "datetime", ylab = "Global reactive power")
                
                
                
        }
        )
}

# printing the plot4 on the screen 
plot4()

# # To store the plot4 as a .png file dev.copy function was used.

dev.copy(png, file = "plot4.png", width = 480, height = 480)

dev.off()