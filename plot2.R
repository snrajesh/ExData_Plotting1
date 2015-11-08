##
## Plot 2: Plot to show relationship between global_active_power and day/time
##

#   setwd('./ExploratoryAnalysis/ExData_Plotting1')
#   source('plot2.R')

#
# 0. Check if data needed for analysis is available in memory
#       - If it is not, call load_and_tidyup_data.R script to do the following:
#       -   a. download file, unzip and load file into a data frame
#       -   b. subset the data frame to just data for 2007-02-01 and 2007-02-02
#       -   c. add datetime column by combining Date and Time columns
#       -   d. create the final tidy data set as "tbTidyData"
# Note: This step takes about 10 seconds first time.

if (!exists("tbTidyData")) {
    source('load_and_tidyup_data.R')
}

#
# 2.    Create Plot to show relationship between global_active_power and day/time and output as a png file (plot2.png)
#

with(tbTidyData, plot(datetime, Global_active_power, type = 'l',
                    xlab = '',
                    ylab = 'Global Active Power (kilowatts)'
                ))

dev.copy(device = png, file = 'plot2.png', width = 480, height = 480)
dev.off()
