 ## R script for Plot 4. 
library("sqldf")
library(dplyr)
  # SQL file used to read data.
### WARNING!  Very long read time.  Please seee plot1.R for more detail.
  # A write and read script is below, which saves time for all other evaluations.
hpc <- read.csv2.sql("household_power_consumption.txt",
                     sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
 ## Combine date and time and convert into character class and then combind
  # with rest of the data. 
DateTime <- as.character(paste0(hpc$Date, " ", hpc$Time))
d <- cbind(DateTime, select(hpc, -Time, -Date))
 ## Plot "plot4.png".
  # Global_active_power
library(grDevices)
png(filename="plot4.png",width=480,height=480, type = c("windows"))
par(mfrow=c(2,2))
plot(d$Global_active_power~d$DateTime, xaxt="n", type = "l", ylab = "Global Active Power (killowatts)", xlab = "")
axis(1, at=c(1, 1440, 2880), lab=c("Thu","Fri", "Sat"))
lines(d$DateTime, d$Global_active_power)
  # Voltage
plot(d$Voltage~d$DateTime, xaxt="n", type = "l", ylab = "Voltage", xlab = "datetime")
axis(1, at=c(1, 1440, 2880), lab=c("Thu","Fri", "Sat"))
lines(d$DateTime, d$Voltage, col = "black") 
  # Sub_metering
plot(as.numeric(d$Sub_metering_1)~d$DateTime, xaxt="n", type = "l", ylab = "Energy sub metering", xlab = "")
axis(1, at=c(1, 1440, 2880), lab=c("Thu","Fri", "Sat"))
lines(as.numeric(d$DateTime), d$Sub_metering_1, col = "black")
lines(as.numeric(d$DateTime), d$Sub_metering_2, col = "red")
lines(as.numeric(d$DateTime), d$Sub_metering_3, col = "blue")
legend(1335, 39, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black","red","blue"), cex=0.8, lty=c(1,1), box.col = "white")
  # Global_reactive_power
plot(d$Global_reactive_power~d$DateTime, xaxt="n", type = "l", ylab = "Global_reactive_power", xlab = "datetime")
axis(1, at=c(1, 1390, 2880), lab=c("Thu","Fri", "Sat"))
lines(d$DateTime, d$Global_reactive_power, col = "black")
dev.off()
############################################
 ## A script for writing and reading csv file.  
  # This is a time saver for additional plots.
write.table(d, file = "hpcData.csv", sep = ",")
d <- read.csv("hpcData.csv")
############################################
 # Code and code inspiration came from numerous sources, including several Coursera courses that teach R. Additionally, package information available in R was extensively used. Other sources are specifically listed in references.
### References
  # 1. R Cookbook, by Paul Teetor, O’Reilly Media, March 2011, 436 pages.
  # 2. R Graphics Cookbook, by Winston Chang, O’Reilly Media, Inc., December 2012, 416 pages
  # 3. R in Action: Data Analysis and Graphics With R, by Robert Kabacoff, Manning Publications Company, 2011, 447 pages.
  # 4. Quick-R, <http://www.statmethods.net/>
  # 5. Stack Overflow, <http://stackoverflow.com/>
  # 6. Introduction to dplyr, <http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html>
  # 7. How dplyr replaced my most common R idioms, <http://www.statsblogs.com/2014/02/10/how-dplyr-replaced-my-most-common-r-idioms/>
  # 8. Tidy Data, by Hadley Wickham, <http://vita.had.co.nz/papers/tidy-data.pdf>
