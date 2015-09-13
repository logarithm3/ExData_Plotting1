
power<- read.csv("household_power_consumption.txt", sep = ";",dec = ".", numerals = c("allow.loss"))

# make Sub_metering a numeric correct date & time format 

power[, "Sub_metering_1"] <- as.numeric(as.character( power[, "Sub_metering_1"] ))
power[, "Sub_metering_2"] <- as.numeric(as.character( power[, "Sub_metering_2"] ))
power[, "Sub_metering_3"] <- as.numeric(as.character( power[, "Sub_metering_3"] ))
power[, "Global_active_power"] <- as.numeric(as.character( power[, "Global_active_power"] ))
power[, "Global_reactive_power"] <- as.numeric(as.character( power[, "Global_reactive_power"] ))
power[, "Voltage"] <- as.numeric(as.character( power[, "Voltage"] ))
power[, "NDateTime"] <- paste(power[, "Date"], power[, "Time"] )
power[, "finalDate"] <- as.POSIXct(power[, "NDateTime"], format = "%d/%m/%Y %H:%M:%S")

# filter dates
powerfiltered <- power[power$finalDate >= as.POSIXct("1/2/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S") 
                       & power$finalDate < as.POSIXct("3/2/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S"),]

# Save PNG file
> png("plot4.png", width = 480, height = 480 )  


# plot 
par(mfrow = c(2, 2), mar = c(4,4,3,2))
with (powerfiltered, {
      
      #1st chart
      plot(powerfiltered$finalDate,powerfiltered$Global_active_power, col = "white", xlab = "",
           ylab = "Global Active Power (kilowatts)")
            lines(powerfiltered$finalDate, powerfiltered$Global_active_power,  col='black', type='l',lwd=1)

      #2nd chart
      plot(powerfiltered$finalDate,powerfiltered$Voltage, col = "white", xlab = "datetime",
           ylab = "Voltage",cex=0.6)
      lines(powerfiltered$finalDate, powerfiltered$Voltage,  col='black', type='l',lwd=1)
      
      
      #3rd chart
      plot(powerfiltered$finalDate,powerfiltered$Sub_metering_1, col = "white", xlab = "",
      ylab = "Energy sub metering",cex=0.6, ylim=c(0,40))
            lines(powerfiltered$finalDate, powerfiltered$Sub_metering_1,  col='black', type='l',lwd=1)
            lines(powerfiltered$finalDate, powerfiltered$Sub_metering_2,  col='red', type='l',lwd=1)
            lines(powerfiltered$finalDate, powerfiltered$Sub_metering_3,  col='blue', type='l',lwd=1)

            legend("topright",pch=1, col= c("black", "red", "blue"),
                   legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.6)

      #4th chart
      plot(powerfiltered$finalDate,powerfiltered$Global_reactive_power, col = "white", xlab = "datetime",
           ylab = "Global_reactive_power", cex=0.6)
      lines(powerfiltered$finalDate, powerfiltered$Global_reactive_power,  col='black', type='l',lwd=1)
      



})
dev.off()