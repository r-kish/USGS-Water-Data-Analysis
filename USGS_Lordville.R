### USGS Water Data Analysis - Delaware River @ Lordville, New York ###
### Richard Kish
### Site ID: 01427207
library(ggplot2)
library(dplyr)
library(tidyverse)

#Importing USGS Daily Data into RStudio (Delaware @ Lordville)
usgsDailyData = read.table("https://waterdata.usgs.gov/nwis/dv?cb_00060=on&cb_00065=on&format=rdb&site_no=01427207&referred_module=sw&period&begin_date=1900-01-01&end_date=2024-01-01", header=T, sep= "\t")

#Remove unnecessary top row
usgsDailyData=usgsDailyData[-c(1),]

#Cleaning usgsDailyData for data used
usgsDailyData_Filtered = usgsDailyData
usgsDailyData_Filtered = subset(usgsDailyData_Filtered, select = -c(1,5))

#Change column name for easy scripting
names(usgsDailyData_Filtered)[3]<-"Mean Discharge [ft3/s]"

#Extract water discharge/flow rate from main dataframe
chardischarge=as.character(usgsDailyData_Filtered[,3])
doubledischarge=as.double(chardischarge)


###Computing Statistics###

#Initialize and construct statistics matrix
Mean_Discharge_Stats= matrix(NA, nrow = 1, ncol = 5)
colnames(Mean_Discharge_Stats)[5] <- "Standard Deviation"
colnames(Mean_Discharge_Stats)[1] <- "Average"
colnames(Mean_Discharge_Stats)[2] <- "Median"
colnames(Mean_Discharge_Stats)[3] <- "Minimum"
colnames(Mean_Discharge_Stats)[4] <- "Maximum"

#Calculate water flow rate values (avg, median, min, max, std dev)
mavg=mean(doubledischarge ,na.rm=TRUE)
mmedian=median(doubledischarge ,na.rm=TRUE)
mmin=min(doubledischarge ,na.rm=TRUE)
mmax=max(doubledischarge ,na.rm=TRUE)
std=sd(doubledischarge ,na.rm=TRUE)

#Affix values to dataframe
Mean_Discharge_Stats[1,1] = mavg
Mean_Discharge_Stats[1,2] = mmedian
Mean_Discharge_Stats[1,3] = mmin
Mean_Discharge_Stats[1,4] = mmax
Mean_Discharge_Stats[1,5] = std

print(Mean_Discharge_Stats)

#Initialize and construct flow rate percentiles matrix
Mean_Discharge_Percentiles= matrix(NA, nrow = 1, ncol = 4)
colnames(Mean_Discharge_Percentiles)[4] <- "99%"
colnames(Mean_Discharge_Percentiles)[1] <- "25%"
colnames(Mean_Discharge_Percentiles)[2] <- "75%"
colnames(Mean_Discharge_Percentiles)[3] <- "90%"
names(Mean_Discharge_Percentiles)[1] <- "Mean Discharge [ft3/s]"

#Calculate percentiles from flow rate data
Mean_Discharge_Percentiles[1,1] = quantile(doubledischarge,0.25,na.rm=T)
Mean_Discharge_Percentiles[1,2] = quantile(doubledischarge,0.75,na.rm=T)
Mean_Discharge_Percentiles[1,3] = quantile(doubledischarge,0.90,na.rm=T)
Mean_Discharge_Percentiles[1,4] = quantile(doubledischarge,0.99,na.rm=T)

print(Mean_Discharge_Percentiles)

#Density plot of Delaware River Discharge throughout history
doubledischarge <- data.frame(doubledischarge)
ggplot(doubledischarge, aes(x = doubledischarge)) +
  geom_density(fill = "blue", alpha = 0.8) +
  xlab("Discharge (Flow Rate) [ft^3/s]") +
  ggtitle("Density of Delaware River Discharge")

#Get time series of 1 month of flow rate
usgsDailyDataSub <- usgsDailyData_Filtered %>% slice(98:127)
usgsDailyDataSub[3] <- lapply(usgsDailyDataSub[3], as.numeric)
ggplot(data=usgsDailyDataSub, aes(x=datetime, y=`Mean Discharge [ft3/s]`, group=1)) +
  geom_line()+
  geom_point() + ggtitle("Flow rate of Delaware River @ Lordville November 2006")
