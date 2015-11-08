library(sqldf)
library(png)
library(ggplot2)

# reading the data
df<-read.csv2("exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE, na.strings = "?")


# converting Date and Time variables to Date/Time classes
df$Date <- as.Date(df$Date , "%d/%m/%Y")
df$Time <- paste(df$Date, df$Time, sep=" ")
df$Time <- strptime(df$Time, "%Y-%m-%d %H:%M:%S")

# subsetting data in those two dates
data<-subset(df, df$Date == "2007-02-01" | df$Date=="2007-02-02")

# converting column to be numeric
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

#plotting and saving file (polish names of the week days stayed...)
png(file="plot3.png")
with(data, plot(Time, Sub_metering_1, type="l"))
with(data, lines(Time, Sub_metering_2, type="l", col="red"))
with(data, lines(Time, Sub_metering_3, type="l", col="blue"))
legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
