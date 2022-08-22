---
output:
  pdf_document: default
  html_document: default
---
# Peer-graded Assignment: Getting and Cleaning Data Course Project 

This project deals with getting and tidying large data set, particularly Human 
Activity Recognition Using Smartphone Data Set[^1]. 
The original data contains a lot of information related to six different 
activities of 30 volunteers, which has been partitioned into two sets: training
data and test data. Extracting the desired information and automating the tidying 
process is the main goal of the project. There is an R script (run_analysis.R), 
output of R script :a tidy data file (tidydata.txt), and a code book (CodeBook.md)
in the project.

## The purpose of the R script (run_analysis.R) is

 * Merges the training and the test sets to create one data set.
 * Extracts only the the measurements on the mean and standard deviation for 
 each measurement.
 * Uses descriptive activity names to name the activities in the data set.
 * Appropriately labels the data set with descriptive variable names.
 * From the data set in step 4, creates a second, independent tidy data set with
 the average of each variable for each activity and each subject.
 
## Tidy data (tidydata.txt) is the output of the R script
 
## The purpose of the code book (CodeBook.md) is:
 
  * Describes the variables and the data.
  * Transformations and work I performed to clean up the data. 
  
 
[^1]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones