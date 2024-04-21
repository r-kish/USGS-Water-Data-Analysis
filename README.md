# USGS Water Data Analysis
### Contents
- [Introduction](Intro)
- [Flow Rate Analysis](#mean-discharge-(flow-rate)-analysis)
- [Linear Regression Analysis](#linear-regression-analysis-on-log-log-scale-of-mean-discharge-(ft^3/s)-vs.-mean-stage-height-(ft))
  
# Introduction <img width = 400, align="right" src= "https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/RawData.png">
This project derives from a project I had been working on during my time studying civil engineering, and relies on publicly accessible from [USGS Water Data](https://waterdata.usgs.gov/nwis) (see image on right of raw data) in order to analyze the behavior of bodies of water recorded by USGS. I specifically focus on the flow rate (discharge) of the Delaware River at Lordville, NY, and both the flow rate and height of the Tusolameta Creek at Walnut Grove, MS using historical data. 

### USGS Raw Water Data Links:
- [Delaware River @ Lordville, NY (Site 01427207)](https://waterdata.usgs.gov/nwis/dv?cb_00060=on&cb_00065=on&format=rdb&site_no=01427207&referred_module=sw&period&begin_date=1900-01-01&end_date=2024-01-01) July 28th, 2006 - January 1st, 2024 (Part 1)
    - [Main USGS site for Lordville](https://waterdata.usgs.gov/monitoring-location/01427207/#parameterCode=00065&period=P7D&showMedian=false)
- [Tuscolameta Creek @ Walnut Grove, MS (Site 02483000)](https://waterdata.usgs.gov/nwis/dv?cb_00060=on&cb_00065=on&format=rdb&site_no=02483000&referred_module=sw&period&begin_date=1900-01-01&end_date=2024-01-01) August 28th, 1974 - January 1st, 2024 (Part 1 & 2)
    - [Main USGS site for Walnut Grove](https://waterdata.usgs.gov/monitoring-location/02483000/#parameterCode=00065&period=P7D&showMedian=false)


# Mean Discharge (Flow Rate) Analysis
This portion of the study will focus on the mean discharge (flow rate) of both bodies of water: the Delaware River, and the Tuscolameta Creek.
The analysis is broken down into three sections:
- Flow Rate Statistics Report
- Flow Rate Percentiles
- Density Plots of Flow Rate
- Daily Flow Rate Time Series (November 2006)

## Mean Discharge (Flow Rate) [ft^3/s] Statistics
The flow rate is determined by the volume of fluid that passes a point in a specified amount of time (V/t). Data is pulled from the entirety of available data for both bodies of water, and the average, medium, minimum, maximum, and standard deviation are calculated.

### Delaware River @ Lordville
![LordvilleStats](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/LordvilleDischarge.png)

### Tuscolameta Creek @ Walnut Grove
![WalnutGroveStats](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/WalnutGroveDischarge.png)

As the Delaware River is a bigger body of water than the Tuscolameta, it makes sense that the Lordville stats are greater than the Walnut Grove stats. Although the Walnut Grove historical data going as far back as 1974, whereas the Lordville data only going back to 2006 could leave room for discrepancy if trying to use this data in a correlational study between the two bodies of water.


## Mean Discharge (Flow Rate) [ft^3/s] Percentiles
Additionally, I've calculated the mean discharge at the 25th, 75th, 90th, and 99th percentile for each body of water. Again, this data is taken from the entirety of all data available for each body of water.

### Delaware River @ Lordville
![LordvillePercentiles](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/LordvillePercentiles.png)

### Tuscolameta Creek @ Walnut Grove
![WalnutGrovePercentiles](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/WalnutGrovePercentiles.png)


## Density Plots of Discharge (Flow Rate)
To get a better visual of how the mean daily discharge is distributed across the entirety of the historical data availble, I've created density plots for each of the bodies of water. The Tuscolameta Creek data is much more dense than the Delaware River, with high outliers being more extreme than that of the Delaware as well. Even though the Tuscolameta Creek is much smaller than the Delaware River at the locations the data was recorded, the Tuscolameta's maximum flow rates were sometimes nearly as that of the maximums of the Delaware.

### Delaware River @ Lordville
![LordvilleDensity](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/LordvilleDensity.png)

### Tuscolameta Creek @ Walnut Grove
![WalnutGroveDensity](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/WalnutGroveDensity.png)


## Mean Daily Discharge Time Series (November 2006)
The data in this section was taken from November 1st, 2006 - November 30th, 2006. The daily mean discharge of both bodies of water is visualized, showing how the flow rate behavior changes over the course of the month. Changes in flow rate for both bodies of water can be the cause of weather; however, in the case of the Delaware River @ Lordville, the release of the Cannonsville Reservoir may have also contributed to changes in flow rate.

### Delaware River @ Lordville
![Lordville](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/Lordville2006.png)

### Tuscolameta Creek @ Walnut Grove
![Walnut Grove](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/WalnutGrove2006.png)

# Linear Regression Analysis on Log-Log Scale of Mean Discharge (ft^3/s) vs. Mean Height (ft)
Since the Delaware River @ Lordville data does not contain historical data for the mean height- so I have left it out of this portion of the study. However, the Tuscolameta Creek data has both mean discharge and mean height data available, so this will be the only body of water in discussion for this section.

After the linear model was created using the log of both the mean discharge, and mean stage-height, the following summary was created:

![Summary](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/LogSummary.png)

These values are used to construct the formula for the linear regression line for the log-log scale comparison of discharge v. height. The next four plots were derived from the linear model summary calculation.

### Summary Part 1: Residuals vs. Fitted Values | Quantile-Quantile Residuals 
![Summary1](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/ResFit_QQRes.png)

### Scale-Location of Square Root of Residuals vs. Fitted Values | Residuals vs. Leverages
![Summary2](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/ScaleLocFit_CookDistLeverage.png)

### As per the documentation for the lm() function in R:
- The Q-Q plot is based on the absolute value of the standardized deviance residuals. When the saddlepoint approximation applies, these have an approximate half-normal distribution.
- The ‘Scale-Location’ plot (which=3), also called ‘Spread-Location’ or ‘S-L’ plot, takes the square root of the absolute residuals in order to diminish skewness.
- The Residual-Leverage plot (which=5) shows contours of equal Cook's distance, for values of cook.levels (by default 0.5 and 1) and omits cases with leverage one with a warning.
    - If the leverages are constant (as is typically the case in a balanced aov situation) the plot uses factor level combinations instead of the leverages for the x-axis. (The factor levels are ordered by mean fitted value.)

## Linear Regression on Log-log Scale of Discharge vs. Stage-height of Tuscolameta Creek
Here, the actual discharge vs. stage-height is displayed alongside the log-log scale of the same comparison. A linear regression line was calculated from the linear model summary report (see above) and has been added to the log-log graph.

![Plot](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/FlowVsHeight.png)
