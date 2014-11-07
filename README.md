# 	This README file provides the necessary steps to execute the R files for the plots.
## 	Steps
	1. Install the sqldf package (if the package already installed then skip this step, multiple installations provide errors)
        * install.packages("sqldf")
	2. load the library
        * library(sqldf)
	3. if the version of RSQLite package is 1.0.0 then the following source code is required for the error free execution.
        * source("http://sqldf.googlecode.com/svn/trunk/R/sqldf.R")
##	NOTES:
	*  There is bug regarding the compatibility between RSQLite (version 1.0.0) and sqldf (version 0.4-9).
	* For the plot4, there are two files, one has the requested 480X480 dimensions (plot4.png), and the other has 520X480 (plot4-520-480.png) which looks better.
		
