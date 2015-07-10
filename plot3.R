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

## Combine the Date and Time values and convert the result to POSIXct with the required date format
PowerConsumptionDF$DateTime <- strptime(paste(PowerConsumptionDF$Date, PowerConsumptionDF$Time), format="%d/%m/%Y %H:%M:%S")

## Open the PNG device for creating the plot to
png("plot3.png", width=480, height=480)

## Create the plot with Sub metering 1 then add lines for Sub metering 2 & 3 and at last add the legend
plot(PowerConsumptionDF$DateTime, PowerConsumptionDF$Sub_metering_1, type="l", col="black", ylab="Energy sub metering",xlab="")
lines(PowerConsumptionDF$DateTime, PowerConsumptionDF$Sub_metering_2, col="red")
lines(PowerConsumptionDF$DateTime, PowerConsumptionDF$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"), bty="n")

## Close the PNG device
dev.off()