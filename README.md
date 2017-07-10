# Getting and Cleaning Data - Course Project

## Overview
This repository contains all the required documents for the course project of Coursera Getting and Cleaning Data. The list of documents is as below:

* run_analysis.R
* DataMean.txt
* CodeBook.md

## Description of Documents

### run_analysis.R
This R script does the following to the UCI HAR Dataset:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### DataMean.txt
This is the output tidy data created by running run_analysis.R.

### CodeBook.md
This is the code book that describes the variables, the data, and any transformations or work that are performed to clean up the original data.
