 ## R script for plot 1.
 ## Zip data file was downloaded, unzipped and saved to working directory.
  # The 2880 lines of data were read with the sqldf package.  Please see 
  # http://code.google.com/p/sqldf/ for additional information and examples.
### WARNING!  The proc.time function gives the following results:
  # user   system   elapsed 
  # 14.44    1.83   1577.91 
  # Computer system: Windows 8.1, 3.6 GHz, 8 GB RAM, with Rstudio 0.98.501.  
  # A write and read script is below, which saves time for all other evaluations.
library("sqldf")
hpc <- read.csv2.sql("household_power_consumption.txt",
                     sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'")
 ## Combine date and time and convert into character class and then combind
  # with rest of the data. 
library(dplyr)
DateTime <- as.character(paste0(hpc$Date, " ", hpc$Time))
d <- cbind(DateTime, select(hpc, -Time, -Date))
 ## Convert factor into numeric data.
c <- as.numeric(as.character(d$Global_active_power))
 ## Plot "plot1.png".
png(file="plot1.png",width=480,height=480)
hist(c, col="red", xlab = 'Global Acive Power (kilowatts)', main = "Global Active Power")
dev.off()
############################################
 ## A script for writing and reading csv file.  
  # This is a time saver for additional plots.
write.table(d, file = "hpcData.csv", sep = ",")
d <- read.csv("hpcData.csv")
############################################
  # Code and code inspiration came from numerous sources, including several Coursera courses that teach R.  Additionally, package information available in R was extensively used.  Other sources are specifically listed in references. 
### References
  #  1.  R Cookbook, by Paul Teetor, O’Reilly Media, March 2011, 436 pages.
  #  2.  R Graphics Cookbook, by Winston Chang, O’Reilly Media, Inc., December 2012,  416 pages
  #  3.  R in Action: Data Analysis and Graphics With R, by Robert Kabacoff, Manning Publications Company, 2011, 447 pages.
  #  4.  Quick-R, <http://www.statmethods.net/>
  #  5.  Stack Overflow,  <http://stackoverflow.com/>
  #  6.  Introduction to dplyr, <http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html>
  #  7.  How dplyr replaced my most common R idioms, <http://www.statsblogs.com/2014/02/10/how-dplyr-replaced-my-most-common-r-idioms/>
  #  8.  Tidy Data, by Hadley Wickham, <http://vita.had.co.nz/papers/tidy-data.pdf>
