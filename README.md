# USGS Water Data Analysis
### Contents
- [Introduction](Intro)
- [Flow Rate Analysis](#mean-discharge-(flow-rate)-analysis)
- [Linear Regression Analysis](#linear-regression-analysis-on-log-log-scale-of-mean-discharge-(ft^3/s)-vs.-mean-stage-height-(ft))
  
# Introduction <img width = 400, align="right" src= "https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/RawData.png">
This project derives from a project I had been working on during my time studying civil engineering, and relies on publicly accessible from [USGS Water Data](https://waterdata.usgs.gov/nwis) in order to analyze the behavior of bodies of water recorded by USGS. I specifically focus on the flow rate (discharge) of the Delaware River at Lordville, NY, and both the flow rate and height of the Tusolameta Creek at Walnut Grove, MS using historical data. 

### USGS Raw Water Data Links:
- (Example of data format on right)
- [Delaware River @ Lordville, NY (Site 01427207)](https://waterdata.usgs.gov/nwis/dv?cb_00060=on&cb_00065=on&format=rdb&site_no=01427207&referred_module=sw&period&begin_date=1900-01-01&end_date=2024-01-01) July 28th, 2006 - January 1st, 2024 (Part 1)
    - [Main USGS site for Lordville](https://waterdata.usgs.gov/monitoring-location/01427207/#parameterCode=00065&period=P7D&showMedian=false)
- [Tuscolameta Creek @ Walnut Grove, MS (Site 02483000)](https://waterdata.usgs.gov/nwis/dv?cb_00060=on&cb_00065=on&format=rdb&site_no=02483000&referred_module=sw&period&begin_date=1900-01-01&end_date=2024-01-01) August 28th, 1974 - January 1st, 2024 (Part 1 & 2)
    - [Main USGS site for Walnut Grove](https://waterdata.usgs.gov/monitoring-location/02483000/#parameterCode=00065&period=P7D&showMedian=false)


# Mean Discharge (Flow Rate) Analysis
This portion of the study will focus on the mean discharge (flow rate) of both bodies of water: the Delaware River, and the Tuscolameta Creek.
The analysis is broken down into three sections:
- Flow Rate Statistics Report
- Flow Rate Percentiles
- Daily Flow Rate Time Series (November 2006)

## Mean Discharge (Flow Rate) [ft^3/s] Statistics
The flow rate is determined by the volume of fluid that passes a point in a specified amount of time. Data is pulled from the entirety of available data for both bodies of water, and the average, medium, minimum, maximum, and standard deviation are calculated.

### Lordvile
![LordvilleStats](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/LordvilleDischarge.png)

### Walnut Grove
![WalnutGroveStats](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/WalnutGroveDischarge.png)

As the Delaware River is a bigger body of water than the Tuscolameta, it makes sense that the Lordville stats are greater than the Walnut Grove stats. Although the Walnut Grove historical data going as far back as 1974, whereas the Lordville data only going back to 2006 could leave room for discrepancy if trying to use this data in a correlational study between the two bodies of water.

## Mean Discharge (Flow Rate) [ft^3/s] Percentiles


## Mean Daily Discharge Time Series (November 2006)
The data in this section was taken from November 1st, 2006 - November 30th, 2006. The daily mean discharge of both bodies of water is visualized, showing how the flow rate behavior changes over the course of the month. Changes in flow rate for both bodies of water can be the cause of weather; however, in the case of the Delaware River @ Lordville, the release of the Cannonsville Reservoir may have also contributed to changes in flow rate.

### Lordville
![Lordville](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/Lordville2006.png)

### Walnut Grove
![Walnut Grove](https://github.com/r-kish/USGS-Water-Data-Analysis/blob/main/images/WalnutGrove2006.png)

# Linear Regression Analysis on Log-Log Scale of Mean Discharge (ft^3/s) vs. Mean Stage-height (ft)

## Linear model summary

## Linear regression on log-log scale of Discharge vs. Stage-height
