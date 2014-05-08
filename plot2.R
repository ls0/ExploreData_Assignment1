 ## R script for Plot 2. 
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
 ## Plot "plot2.png".
png(filename="plot2.png",width=480,height=480, type = c("windows"))
par(mfrow=c(1,1))
plot(d$Global_active_power~d$DateTime, xaxt="n", type = "l", ylab = "Global Active Power (killowatts)", xlab = "")
axis(1, at=c(1, 1440, 2880), lab=c("Thu","Fri", "Sat"))
lines(d$DateTime, d$Global_active_power)
dev.off()
############################################
 ## A script for writing and reading csv file.  
  # This is a time saver for additional plots.
write.table(d, file = "hpcData.csv", sep = ",")
d <- read.csv("hpcData.csv")
