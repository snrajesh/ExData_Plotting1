##
##  title: "Exploratory Data Analysis: Course Project 1"
## author: "Rajesh Santha Nambiar"
##  date: "November 04, 2015"
##

########################################################################################################
#About the data:
#
# The dataset has 2,075,259 rows and 9 columns. 
# First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. 
# Make sure your computer has enough memory (most modern computers should be fine).
# 
# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
# One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.
# 
# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
# 
# Note that in this dataset missing values are coded as ?.
#
########################################################################################################


#set project working directory
#   setwd('./ExploratoryAnalysis/ExData_Plotting1')
#
#   source('EDA_project1.R')
#
#   system.time(load_data_and_plot())

load_data_and_plot <- function() {

##
## Step 1: Download file, load files into data.frame.tables, and do initial clean-up
##

    #if (!exists("tbTidyData")){
    
        ### Load dplyr package for easy data manipulation (install if needed)
        if (! require("dplyr")) {
            install.packages('dplyr'); 
            library(dplyr);
        }
        if (! require("data.table")) {
            install.packages('data.table'); 
            library(data.table);
        }    
        
        ### 1.A. Download & unzip file
        
        dataFile <- 'household_power_consumption.txt';
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        localFile <- 'exdata-data-household_power_consumption.zip'
        
        if(!file.exists(dataFile)) {
            if(!file.exists(localFile)) {
                download.file(url = fileUrl, destfile = localFile, mode="wb",method='internal')
            }
            unzip(localFile)
        }
        
        ### 1.B. load using fread into a data frame table (takes about 8-10sec)
        
        tbRawData <- fread(dataFile, sep = ";", na.strings = "?", strip.white = TRUE, # comment.char = "",
                           # colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                           #nrows = 1000, skip = 0,
                           header = TRUE, stringsAsFactors = FALSE
        );
        
        #colclass <- sapply(tbRawData, class)
        #memoryRequired <- 2075259 * 9 * 8 # no. of column * no. of rows * 8 bytes/numeric (/ 2^20 for MB)
        #149,418,648
        
        
        ### 1.C. subset Data for 2007-02-01 and 2007-02-02
        
        tbTidyData <- tbl_df(subset(tbRawData, as.Date(Date,"%d/%m/%Y") == '2007-02-01' 
                                    | as.Date(Date,"%d/%m/%Y") == '2007-02-02'))
        
        ### 1.D. add datetime field by combining Date (in dd/mm/yyyy format) and  time (in hh:mm:ss format)
        
        tbTidyData$datetime <- strptime(paste(tbTidyData$Date,tbTidyData$Time),"%d/%m/%Y %H:%M:%S");
        #tbTidyData <- mutate(tbTidyData,datetime = strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S")) # gives error Error: `mutate` does not support `POSIXlt` results
        
        rm(tbRawData)
    
    #}
    
#######

#
# 2.    Create histogram of Global_active_power and output as a png file (plot1.png)
#

hist(tbTidyData$Global_active_power, col='red', 
     ylim = range(0:1200), xlim = range(0:6),
     main = 'Global Active Power', 
     xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency')

dev.copy(device=png,file='plot1.png', width = 480, height = 480)
dev.off()

#
# 3.    Create Plot to show relationship between global_active_power and day/time and output as a png file (plot2.png)
#

with(tbTidyData, plot(datetime,Global_active_power, type='l', xlab = '',
                      ylab = 'Global Active Power (kilowatts)'#,ylim = range(0:6)
))

dev.copy(device=png,file='plot2.png', width = 480, height = 480)
dev.off()


#
# 4.    Create Plot to show relationship between Energy submetering and day/time and output as a png file (plot3.png)
#

with(tbTidyData, plot(datetime, Global_active_power, type='l', xlab = '',
                      ylab = 'Global Active Power (kilowatts)'#,ylim = range(0:6)
))

plot(tbTidyData$datetime, tbTidyData$Sub_metering_1, type = "l", xlab = '', ylab = 'Energy Sub metering', pch=1)
#points(tbTidyData$datetime, tbTidyData$Sub_metering_1, col='black', type = 'l', pch=1);
points(tbTidyData$datetime, tbTidyData$Sub_metering_2, col='red', type = 'l');
points(tbTidyData$datetime, tbTidyData$Sub_metering_3, col='blue', type = 'l');

legend("topright", pch=c('_','_','_'), col=c("black","red","blue"), 
       legend=c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "))

dev.copy(device=png,file='plot3.png', width = 480, height = 480)
dev.off()



#
# 5.    Create Panel Plot to show relationship between various measurements and day/time and output as a png file (plot4.png)
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

plot(tbTidyData$datetime, tbTidyData$Sub_metering_1, type = "l",   
     xlab = '', ylab = 'Energy Sub metering');
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
# 2E. output panel plot as a png file (plot4.png)
#

dev.copy(device=png,file='plot4.png', width = 480, height = 480)
dev.off()

par(mfrow = c(1,1), cex.lab = 1)

}

