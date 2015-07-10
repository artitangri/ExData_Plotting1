## Set the working Directory to where the file is saved
setwd("C:/Documents/")

## Download the data 
HPC_DF <- read.table(file = "household_power_consumption.txt",header = TRUE, sep=";", stringsAsFactors=FALSE)

## Filter and get the data for 02/01/2007 and 02/02/2007
PowerConsumptionDF <- HPC_DF[HPC_DF$Date == "2/2/2007" | HPC_DF$Date == "1/2/2007",]

## Convert the Sub metering values to numeric
PowerConsumptionDF$Sub_metering_1 <- as.numeric(PowerConsumptionDF$Sub_metering_1)
PowerConsumptionDF$Sub_metering_2 <- as.numeric(PowerConsumptionDF$Sub_metering_2)
PowerConsumptionDF$Sub_metering_3 <- as.numeric(PowerConsumptionDF$Sub_metering_3)
PowerConsumptionDF$Global_reactive_power <- as.numeric(PowerConsumptionDF$Global_reactive_power)
PowerConsumptionDF$Voltage <- PowerConsumptionDF$Voltage

## Combine the Date and Time values and convert the result to POSIXct with the required date format
PowerConsumptionDF$DateTime <- strptime(paste(PowerConsumptionDF$Date, PowerConsumptionDF$Time), format="%d/%m/%Y %H:%M:%S")

## Open the PNG device for creating the plot to
png("plot4.png", width=480, height=480)

##Set the parameter to have 4 plots in 2 rows and 2 columns
par(mfrow=c(2,2))

## Plot the global active power chart against Date Time first
plot(PowerConsumptionDF$DateTime, PowerConsumptionDF$Global_active_power, type="l", yaxt="n", ylab="Global Active Power", xlab="")
## Set the values for the y axis
axis(side = 2, at = seq(0, 6, by=2), labels=c(0,2,4,6))

## Plot the Voltage against Date Time as the second one on the first row
plot(PowerConsumptionDF$DateTime, PowerConsumptionDF$Voltage, type="l", ylab="Voltage", xlab="")


## Plot with Energy metering chart next - second column, first row
plot(PowerConsumptionDF$DateTime, PowerConsumptionDF$Sub_metering_1, type="l", col="black", ylab="Energy sub metering",xlab="")
lines(PowerConsumptionDF$DateTime, PowerConsumptionDF$Sub_metering_2, col="red")
lines(PowerConsumptionDF$DateTime, PowerConsumptionDF$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"), bty="n")

## Plot the Global reactive Power against Date Time as the last one on the second row and second column
plot(PowerConsumptionDF$DateTime, PowerConsumptionDF$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="")

## Close the PNG device
dev.off()