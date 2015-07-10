## Set the working Directory to where the file is saved
setwd("C:/Documents/")

## Download the data 
HPC_DF <- read.table(file = "household_power_consumption.txt",header = TRUE, sep=";")

## Filter out the data for 02/01/2007 and 02/02/2007
PowerConsumptionDF <- HPC_DF[HPC_DF$Date == "2/2/2007" | HPC_DF$Date == "1/2/2007",]

## Convert Global Active Power to numeric
PowerConsumptionDF$Global_active_power <- as.numeric(PowerConsumptionDF$Global_active_power)

##Set up the PNG device to create the histogram
png("plot1.png", width=480, height=480)

## Plot the histogram 
hist(PowerConsumptionDF$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main="Global Active Power", xaxt="n", xlim=c(0,6), ylim=c(0,1200))
axis(side = 1, at = seq(0, 6, by=2), labels=c(0,2,4,6))

## Close the connection to the PNG file
dev.off()