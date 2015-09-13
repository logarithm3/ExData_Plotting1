
power<- read.csv("household_power_consumption.txt", sep = ";",dec = ".", numerals = c("allow.loss"))

# make Global active power a numeric correct date & time format 

power[, "Global_active_power"] <- as.numeric(as.character( power[, "Global_active_power"] ))
power[, "NDateTime"] <- paste(power[, "Date"], power[, "Time"] )
power[, "finalDate"] <- as.POSIXct(power[, "NDateTime"], format = "%d/%m/%Y %H:%M:%S")

# filter dates
powerfiltered <- power[power$finalDate >= as.POSIXct("1/2/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S") 
                       & power$finalDate < as.POSIXct("3/2/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S"),]

 # Save PNG file

png("plot2.png", width = 480, height = 480 )


# plot
plot(powerfiltered$finalDate,powerfiltered$Global_active_power, col = "white", xlab = "",
      ylab = "Global Active Power (kilowatts)")

lines(powerfiltered$finalDate, powerfiltered$Global_active_power,  col='black', type='l',lwd=1)

dev.off()
