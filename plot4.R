##
## Plot 4: Panel Plot to show relationship between Global Active Power, Voltage, Energy submetering, Global reactive power, and day/time
##

#   setwd('./ExploratoryAnalysis/ExData_Plotting1')
#   source('plot4.R')

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
# 2.    Create Panel Plot to show relationship between various measurements and day/time and output as a png file (plot4.png)
#

# set the panel to have 4 plots, and reduce the size of the x & y label by 80% to fit along y-axis

par(mfrow = c(2,2), cex.lab = .8)


# 2A.   Create Plot to show relationship between global_active_power and day/time
#

with(tbTidyData, plot(datetime, Global_active_power, type='l', xlab = '',
                      ylab = 'Global Active Power' 
    ))

# 2B.    Create Plot to show relationship between voltage and day/time

with(tbTidyData, plot(datetime, Voltage, type='l'
                     # , xlab = 'datetime', ylab = 'Voltage' 
    ))

# 2C.    Create Plot to show relationship between Energy submetering and day/time

plot(tbTidyData$datetime, tbTidyData$Sub_metering_1, type = "l", xlab = '', ylab = 'Energy Sub metering');
points(tbTidyData$datetime, tbTidyData$Sub_metering_2, col='red', type = 'l');
points(tbTidyData$datetime, tbTidyData$Sub_metering_3, col='blue', type = 'l');
legend("topright", lty = 1, cex = .5, bty ='n', col = c("black","red","blue"), #pch = c('-','-','-'), 
       legend = c("Sub_metering_1 ","Sub_metering_2 ", "Sub_metering_3 ")
       );

# 2D. Create Plot to show relationship between Gloabl Reactive Power and day/time

with(tbTidyData, plot(datetime, Global_reactive_power, type='l' #, cex.lab = .85
                      #,xlab = 'datetime', ylab = 'Global_reactive_power' #, ylim = range(0.0:0.5)
    ))


#
#3. output panel plot as a png file (plot4.png)
#

dev.copy(device=png,file='plot4.png', width = 480, height = 480)
dev.off()

par(mfrow = c(1,1), cex.lab = 1)
