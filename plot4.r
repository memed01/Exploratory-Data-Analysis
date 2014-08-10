setwd("G:/Data_Scientist/Cours/Exploratory Data Analysis/PROJECT1")
if(!file.exists("data")){dir.create("data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
download.file(fileUrl,"./data/household_power_consumption.zip")
unzip("./data/household_power_consumption.zip", exdir="household_power_consumption")

## Getting entire dataset

household <- read.csv2("household_power_consumption/household_power_consumption.txt")
## read household dates in format 'yyyy-mm-dd'
household$Date <- as.Date(household$Date, format="%d/%m/%Y")
## Subsetting the data
household_subset <- subset(household, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
## Converting dates
datetime <- paste(as.Date(household_subset$Date), household_subset$Time)
## to assume a specific time zone
household_subset$Datetime <- as.POSIXct(datetime)

## Plot 4
household_subset$Sub_metering_1<-as.numeric(household_subset$Sub_metering_1)
household_subset$Sub_metering_2<-as.numeric(household_subset$Sub_metering_2)
household_subset$Sub_metering_3<-as.numeric(household_subset$Sub_metering_3)
household_subset$Global_active_power<-as.numeric(household_subset$Global_active_power)
household_subset$Global_active<-household_subset$Global_active_powe/500
household_subset$Voltage<-as.numeric(household_subset$Voltage)
household_subset$Voltage1<-32*log(household_subset$Voltage)

household_subset$Global_reactive_power<-as.numeric(household_subset$Global_reactive_power)
household_subset$Global_reactive<-household_subset$Global_reactive_power/460

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(household_subset,
{
plot(Global_active~Datetime, type="l", yaxp = c(0, 6, 3),ylab="Global Active Power", xlab="")
plot(Voltage1~Datetime, type="l", ylim = c(214, 246),ylab="Voltage",xlab="datetime")
plot(Sub_metering_1~Datetime, type="l", yaxp = c(0, 30, 3),ylab="Energy sub metering", xlab="")
lines(Sub_metering_2~Datetime,col='Red')
lines(Sub_metering_3~Datetime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(Global_reactive~Datetime, type="l", ylab="Global_Reactive_Power",yaxp = c(0.0, 0.5, 5),xlab="datetime")

}
)
## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()