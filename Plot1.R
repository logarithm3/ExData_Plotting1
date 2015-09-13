
power<- read.csv("household_power_consumption.txt", sep = ";",dec = ".", numerals = c("allow.loss"))

# make Global active power a numeric correct date & time format 

power[, "Global_active_power"] <- as.numeric(as.character( power[, "Global_active_power"] ))
power[, "NDateTime"] <- paste(power[, "Date"], power[, "Time"], "%d/%m/%Y" )
power[, "finalDate"] <- as.Date(power[, "NDateTime"], format = "%d/%m/%Y %H:%M:%S")

# filter dates
powerfiltered <- power[power$finalDate >= as.Date("1/2/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S") 
                       & power$finalDate < as.Date("3/2/2007 00:00:00", format = "%d/%m/%Y %H:%M:%S"),]


  
  # Save PNG file

png("plot1.png", width = 480, height = 480 )
   
# plot
par(mar = c(4,4,2,1))
hist(powerfiltered[,"Global_active_power"],  col ="red", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")

dev.off()
