## Set the working Directory to where the file is saved
setwd("C:/Documents/")

## Download the data 
HPC_DF <- read.table(file = "household_power_consumption.txt",header = TRUE, sep=";", stringsAsFactors=FALSE)

## Filter and get the data for 02/01/2007 and 02/02/2007
PowerConsumptionDF <- HPC_DF[HPC_DF$Date == "2/2/2007" | HPC_DF$Date == "1/2/2007",]

## Convert the Global Active Power to numeric
PowerConsumptionDF$Global_active_power <- as.numeric(PowerConsumptionDF$Global_active_power)

## Combine the Date and Time values and convert the result to POSIXct with the required date format
PowerConsumptionDF$DateTime <- strptime(paste(PowerConsumptionDF$Date, PowerConsumptionDF$Time), format="%d/%m/%Y %H:%M:%S")

## Open the PNG device for creating the plot to
png("plot2.png", width=480, height=480)

## Create the plot
plot(PowerConsumptionDF$DateTime, PowerConsumptionDF$Global_active_power, type="l", yaxt="n", ylab="Global Active Power", xlab="")
## Set the values for the y axis
axis(side = 2, at = seq(0, 6, by=2), labels=c(0,2,4,6))

## Close the PNG device
dev.off()