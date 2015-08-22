# getclean-course-project

Getting and Cleaning Data Course Project

The files in this repository have been written to answer the requirements of the Course Project for the Coursera Datascientist's Toolbox course: Getting and Cleaning Data

The repository consists of three files:
- *readMe.md* - this file explaining the repository and scripts
- codeBook.md - a data dictionary for the data analysed in this project
- run_analysis.R - a single R script that processes a specific dataset as defined in codeBook.md and in accordance with the requirements laid out in this readMe file

This project requires processed the following data set:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

and requires this data set to be in a folder called "data" in the R working directory to function

The run_analysis.R file carries out the following actions:

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with mean of each variable for each activity and each subject.

The run_analysis.R file contains two functions:

import_data() - this function takes one argument "datatype" and uses this to source and merge the data for a particular type of records - either the training or test data

run_analysis() - this function calls import_data() to load the raw data in to R, then merges the training and test together before carrying out a number of tidying functions on it. Finally it copies the data to a new tidy data set and calculates the mean of each activity for each subject.
