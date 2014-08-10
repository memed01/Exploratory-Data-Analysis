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

## Plot 3
household_subset$Sub_metering_1<-as.numeric(household_subset$Sub_metering_1)
household_subset$Sub_metering_2<-as.numeric(household_subset$Sub_metering_2)
household_subset$Sub_metering_3<-as.numeric(household_subset$Sub_metering_3)
with(household_subset, {
plot(Sub_metering_1~Datetime, type="l", yaxp = c(0, 30, 3),ylab="Global Active Power (kilowatts)", xlab="")
lines(Sub_metering_2~Datetime,col='Red')
lines(Sub_metering_3~Datetime,col='Blue')
}
)
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()