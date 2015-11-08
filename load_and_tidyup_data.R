#   setwd('./ExploratoryAnalysis/ExData_Plotting1')
#   source('load_and_tidyup_data.R')

##
## Download file, load files into data.frame.tables, and do initial clean-up (takes about 20 seconds)
##

#if (!exists("tbTidyData")){
    
    ### Load dplyr package for easy data manipulation (install if needed); supress startup messages
    if (! suppressPackageStartupMessages(require("dplyr"))) {
        install.packages('dplyr'); 
        suppressPackageStartupMessages(library(dplyr));
    }
    if (! suppressPackageStartupMessages(require("data.table"))) {
        install.packages('data.table'); 
        suppressPackageStartupMessages(library(data.table));
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
    
    tbTidyData <- tbl_df(subset(tbRawData, 
                                as.Date(Date,"%d/%m/%Y") == as.Date('2007-02-01',"%Y-%m-%d")  | 
                                as.Date(Date,"%d/%m/%Y") == as.Date('2007-02-02',"%Y-%m-%d")
                                ))
    
    ### 1.D. add datetime field by combining Date (in dd/mm/yyyy format) and  time (in hh:mm:ss format)
    
    tbTidyData$datetime <- strptime(paste(tbTidyData$Date,tbTidyData$Time),"%d/%m/%Y %H:%M:%S");
    #tbTidyData <- mutate(tbTidyData,datetime = strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S")) # gives error Error: `mutate` does not support `POSIXlt` results
    
    # remove raw data table and unzipped file
    rm(tbRawData)
    file.remove(dataFile)
    
#}
    