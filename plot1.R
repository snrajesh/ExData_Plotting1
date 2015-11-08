##
## Plot 1: Histogram to show distribution of global_active_power 
##

#   setwd('./ExploratoryAnalysis/ExData_Plotting1')
#   source('plot1.R')

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
# 1.    Create histogram of Global_active_power and output as a png file (plot1.png)
#

hist(tbTidyData$Global_active_power, col='red', 
     ylim = range(0:1200), xlim = range(0:6),
     main = 'Global Active Power', 
     xlab = 'Global Active Power (kilowatts)', 
     ylab = 'Frequency'
     )

dev.copy(device=png, file='plot1.png', width = 480, height = 480)
dev.off()
