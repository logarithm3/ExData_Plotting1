
power<- read.csv("household_power_consumption.txt", sep = ";",dec = ".", numerals = c("allow.loss"))

# make Sub_metering a numeric correct date & time format 

power[, "Sub_metering_1"] <- as.numeric(as.character( power[, "Sub_metering_1"] ))
power[, "Sub_metering_2"] <- as.numeric(as.character( power[, "Sub_metering_2"] ))
power[, "Sub_metering_3"] <- as.numeric(as.character( power[, "Sub_metering_3"] ))
power[, "NDateTime"] <- paste(power[, "Date"], power[, "Time"] )
power[, "finalDate"] <- as.POSIXct(power[, "NDateTime"], format = "%d/%m/%Y %H:%M:%S")

# filter dates
powerfiltered <- power[power$finalDate >= as.POSIXct("1/2/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S") 
                       & power$finalDate < as.POSIXct("3/2/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S"),]
# plot 1st
plot(powerfiltered$finalDate,powerfiltered$Sub_metering_1, col = "white", xlab = "",
      ylab = "Energy sub metering", ylim=c(0,40))

lines(powerfiltered$finalDate, powerfiltered$Sub_metering_1,  col='black', type='l',lwd=1)

# plot 2nd

lines(powerfiltered$finalDate, powerfiltered$Sub_metering_2,  col='red', type='l',lwd=1)

# plot 3rd

lines(powerfiltered$finalDate, powerfiltered$Sub_metering_3,  col='blue', type='l',lwd=1)

legend("topright",pch=1, col= c("black", "red", "blue"),
       legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))