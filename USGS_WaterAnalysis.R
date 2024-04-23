### USGS Water Data Analysis - Tuscolameta Creek @ Walnut Grove, Mississippi
### Richard Kish
### Site ID: 02483000
library(ggplot2)
library(dplyr)
library(tidyverse)

#Importing USGS Daily Data into RStudio
usgsDailyData=read.table("https://waterdata.usgs.gov/nwis/dv?cb_00060=on&cb_00065=on&format=rdb&site_no=02483000&referred_module=sw&period&begin_date=1900-01-01&end_date=2024-01-01", header=T, sep= "\t")

#Remove unnecessary top row
usgsDailyData=usgsDailyData[-c(1),]


#Cleaning usgsDailyData for data used
usgsDailyData_Filtered = usgsDailyData
usgsDailyData_Filtered = subset(usgsDailyData_Filtered, select = -c(1,5,7))
print(usgsDailyData_Filtered)

#Change names for easier scripting
names(usgsDailyData_Filtered)[4]<-"Mean Discharge [ft3/s]"
names(usgsDailyData_Filtered)[3]<-"Mean Stage-height [ft]"

#Extract water discharge/flow rate from main dataframe
chardischarge=as.character(usgsDailyData_Filtered[,4])
doubledischarge=as.double(chardischarge)

#Extract water gauge height from main dataframe
charheight=as.character(usgsDailyData_Filtered[,3])
doubleheight=as.double(charheight)


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

#Density plot of Tuscolameta Creek Discharge throughout history
doubledischarge <- data.frame(doubledischarge)
ggplot(doubledischarge, aes(x = doubledischarge)) +
  geom_density(fill = "red", alpha = 0.8) +
  xlab("Discharge (Flow Rate) [ft^3/s]") +
  ggtitle("Density of Tuscolameta Creek Discharge")

#Get time series of 1 month of flow rate
usgsDailyDataSub <- usgsDailyData_Filtered %>% slice(11755:11784)
usgsDailyDataSub[4] <- lapply(usgsDailyDataSub[4], as.numeric)
ggplot(data=usgsDailyDataSub, aes(x=datetime, y=`Mean Discharge [ft3/s]`, group=1)) +
  geom_line()+
  geom_point() + ggtitle("Flow rate of Tuscolameta Creek @ Walnut Grove November 2006")


###Linear regression analysis on Log-Log scale Mean Discharge [ft3/s] vs Mean Stage-height [ft]

#Setup new dataframe for linear regression analysis
usgsDailyData_Filtered_2=usgsDailyData_Filtered
usgsDailyData_Filtered_2[usgsDailyData_Filtered_2==""]=NA
usgsDailyData_Filtered_2=na.omit(usgsDailyData_Filtered_2)

#Set Mean Discharge and Stage-height to numeric
usgsDailyData_Filtered_2$`Mean Discharge [ft3/s]`=as.numeric(as.character(usgsDailyData_Filtered_2$`Mean Discharge [ft3/s]`))
class(usgsDailyData_Filtered_2$`Mean Discharge [ft3/s]`)
usgsDailyData_Filtered_2$`Mean Stage-height [ft]`=as.numeric(as.character(usgsDailyData_Filtered_2$`Mean Stage-height [ft]`))
class(usgsDailyData_Filtered_2$`Mean Stage-height [ft]`)

#Calculate log of water data
logmeand=log(usgsDailyData_Filtered_2$`Mean Discharge [ft3/s]`)
logstageh=log(usgsDailyData_Filtered_2$`Mean Stage-height [ft]`)
usgsDailyData_Filtered_2["LogMeanDischarge"]=logmeand
usgsDailyData_Filtered_2["LogMeanStageheight"]=logstageh

#Create a linear model using the log-log scale of water data
lm=lm(logmeand ~ logstageh)
plot(lm)
summary(lm)

#Create linear regression line conditions (from summary)
LinearReg_Intercept=-14.40532
LinearReg_Slope=7.33142
LinearReg_RSquared=0.8273

#Setup and visualize discharge vs height (including log-scale)
par(mfrow = c(1,2))
plot(usgsDailyData_Filtered_2[,4],usgsDailyData_Filtered_2[,3], xlab="Mean Discharge [ft3/s]",
     ylab="Mean Stage-height [ft]")
plot(logmeand,logstageh, xlab="log(Mean Discharge [ft3/s])",
     ylab="log(Mean Stage-height [ft])")

#Add in linear regression line
abline(lm(logstageh ~ logmeand), col="red")
text(x=4, y=3.4, label="Y= 7.33142*X + (-14.40532)")
