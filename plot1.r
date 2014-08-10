setwd("I:/Data_Scientist/Cours/Exploratory Data Analysis/PROJECT1")
#setwd("G:/Data_Scientist/Cours/Exploratory Data Analysis/PROJECT1")
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
## Plot 1
household_subset$Global_active_power<-as.numeric(household_subset$Global_active_power)
household_subset$Global_active<-household_subset$Global_active_powe/500
hist(household_subset$Global_active, main="Global Active Power", xlab="Global Active Power (kilowatts)",yaxp = c(0, 6, 3), ylab="Frequency", col="Red")
## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()