---
title: "README - Tidy Data for HAR Dataset"
author: "Valerie QUINIOU"
date: "10/9/2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## README
This code is built following the Coursera courses "Getting and Cleaning Data" - Week 4 / Assignment instructions.
The assignment aims at creating a tidy data set using provided material which are :
various .txt files provided which are the result of a study dealt upon Human Activity Recognition Using Smartphones Dataset. For further information on the study please refer to the readme.txt file in the UCI HAR Dataset package.

In order to test the code fully, please follow the instructions below : 

# Step 1 - setting up the environment
First, create a dedicated directory for testing the code, you can call it "TidyData" for example.
Download the README.md and CodeBook.rmd files into the newly created directory. The CodeBook describes all steps of the run_analysis.R script as well as it provides the description of the tidy data set (tidyData.txt) variables.
Download the README.md file ant the run_analysis.R file into the newly created directory
Then, download and unzip the UCI HAR Dataset in the newly created directory.

The structure of your Directory should be similar to : 

TidyData/
        CodeBook.Rmd
        README.MD (this is the present file)
        run_analysis.R (the code to be tested)
        tidyData.txt (the result you should obtain)
        /UCI HAR Dataset/
                activity_labels.txt
                features_info.txt
                features.txt
                README.txt
                /test/
                        /Inertial Signals/
                                contains other .txt files which are raw data, but we are not going to use them
                        subject_test.txt
                        X_test.txt
                        Y_test.txt
                /train/
                        /Inertial Signals/
                                contains other .txt files which are raw data, but we are not going to use them
                        subject_train.txt
                        X_train.txt
                        Y_train.txt
                
Open the R console or RStudio and set your Working Directory to the TidyData directory

# Step 2 - launch the script
Source the run_analysis.R script into the R console or RStudio.

# Step 3 - check the data set
2 Ways to do that : 
- Check in the Working Directory that the file tidyData.txt was created.
- In the R console or Rstudio, read the tidyData.txt file using the following command : 
        library(data.table)
        fread ("tidyData.txt", sep = " ", header = TRUE)
        
the data set dimension is 180 obs. and 81 variables        
        

