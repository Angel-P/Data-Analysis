---
title: "README"
output: html_document
---
README
------------------------------------------------------------------------------

Thank you for taking the time to evaluate my submission. I will keep it brief
and to the point. This script assumes you have the UCI HAR Dataset set as your
working directory. File paths are fixed, if you're in another WD this script will 
not work.

On a step by step basis , the script does the following:

- Reads all the necessary data into R via read.csv commands. Use of the sep =
option is crucial here, as some files are separated by spaces/commas/dashes, etc.
        - This data includes:
                - Test and Train Datasets
                - Activity Labels
                - Subject Data
                - Features Data 
                
- Proceeds to append column names to each separate data set PRIOR to merging.
The order is extremely important, as this script relies on the natural ordering
that R gives its data.

- Proceeds to coerce variable column.names into characters in order to use 
rbind function successfully. 

- It then appends the data type (I.E Mean, std dev, kurtosis, etc) into each column
for future indexing

- Since column.names data was appended to each dataset, the activity labels data.frame is now one entry short for appending. Addition of one row of NA values was 
used in order to make the data.frames match and be able to use positional matching of values.

- Step is repeated for subject data.

- The train and test data frames are now merged, each one having their respective
activity/subject data appended to it. The script then cuts out all unncecessary columns not related to either Mean or Std Dev. * THIS IS CONSIDERED TIDY DATA 1, A MERGED DATA.FRAME WITH SUBJECT AND ACTIVITY APPENDED WHOSE COLUMNS ONLY REFER TO MEAN AND STD DEV DATA.

-As requested, the script then turns activity data into character entries via clever use of R subsetting mechanics.

- The data is then melted into a thin data frame with the ID variables being Activity and Subject. Data is very nearly tidy.

- Tidy data.frame is created via dcast command. Ordered pairs of activity/subject are matched with the respective mean of their data. 

- The data is now tidy. All is well with the world.