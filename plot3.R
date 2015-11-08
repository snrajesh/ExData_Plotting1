##
## Plot 3: Plot to show relationship between Energy submetering and day/time
##

#   setwd('./ExploratoryAnalysis/ExData_Plotting1')
#   source('plot3.R')

#
# 0. Check if data needed for analysis is available in memory
#       - If it is not, call load_and_tidyup_data.R script to do the following:
#       -   a. download file, unzip and load file into a data frame
#       -   b. subset the data frame to just data for 2007-02-01 and 2007-02-02 
#       -   c. add datetime column by combining Date and Time columns
#       -   d. create the final tidy data set as "tbTidyData"
# Note: This step takes about 10 seconds first time.

if (!exists("tbTidyData")){
    source('load_and_tidyup_data.R')
}

#
# 2.    Create Plot to show relationship between Energy submetering and day/time and output as a png file (plot3.png)
#

plot(tbTidyData$datetime, tbTidyData$Sub_metering_1, type = "l", xlab = '', ylab = 'Energy Sub metering');
points(tbTidyData$datetime, tbTidyData$Sub_metering_2, col='red', type = 'l');
points(tbTidyData$datetime, tbTidyData$Sub_metering_3, col='blue', type = 'l');
legend("topright", lty = 1, cex = .75, col = c("black","red","blue"), #pch = c('-','-','-'), 
       legend = c("Sub_metering_1 ","Sub_metering_2 ", "Sub_metering_3 ")
       );

dev.copy(device=png, file='plot3.png', width = 480, height = 480)
#png(filename='plot3a.png')
dev.off()
