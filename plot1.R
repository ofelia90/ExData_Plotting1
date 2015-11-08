library(sqldf)
library(png)

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

#plotting and saving file
png(file="plot1.png")
with(data,hist(Global_active_power, main = "Global Active power", col = "red", xlab = "Global Active Power (kilowatts)" ))
dev.off()
