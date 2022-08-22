library(dplyr)

run_analysis <- function(){
  
  ##Download and unzip the data folder
  zipfile <- "./data.zip"
  if(!file.exists(zipfile)){
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, destfile = zipfile, method = "curl")
  }
  
  if(!file.exists("UCI HAR Dataset")){
    unzip(zipfile)
  }
  ##Downloading and unzipping ends
  
  ##Read the files into variables
  
  ##Activities and Features
  act <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
  feat <- read.table("UCI HAR Dataset/features.txt", col.names = c("serial", "features"))
  ##TRAIN
  train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
  train_X <- read.table("UCI HAR Dataset/train/X_train.txt" , col.names = feat$features)  
  train_y <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code") 
  ##TEST
  test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
  test_X <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = feat$features)  
  test_y <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code") 
  ##Reading ends
  
  ##Merging Train and Test sets to create one dataset
  subject <- bind_rows(train_subject, test_subject)
  X <- bind_rows(train_X, test_X)
  y <- bind_rows(train_y, test_y)
  ## Make sure X contains only the columns with names "mean" and "std" in them
  X <- X %>%
    select(contains("mean")|contains("std"))
  fin <- bind_cols(subject, y)
  ##Merging ends
  
  ##Uses descriptive activity names to name the activities in the data set
  fin <- fin %>%
    mutate(activity = act$activity[code]) %>%
    select(-code) %>%
    bind_cols(X)
  ##Naming activity ends
  
  ##Appropriately labels the data with descriptive variable names
  names(fin) <- gsub("Acc", " Accelorometer ", names(fin))
  names(fin) <- gsub("Gyro", " Gyroscope ", names(fin))
  names(fin) <- gsub("^t", "time ", names(fin))
  names(fin) <- gsub("^f", "frequency ", names(fin))
  names(fin) <- gsub("Mag", " Magnitude ", names(fin))
  names(fin) <- gsub("std", " Standard deviation ", names(fin))
  names(fin) <- gsub("mad", " Median absolute deviation ", names(fin))
  names(fin) <- gsub("sma", " Signal magnitude area ", names(fin))
  names(fin) <- gsub("iqr", " Interquartile range ", names(fin))
  names(fin) <- gsub("arCoeff", " Autoregression coefficients ", names(fin))
  names(fin) <- gsub("tBody", " time Body ", names(fin))
  names(fin) <- gsub("\\.", "", names(fin))
  ##Labelling ends
  
  ##Create another data set with the average of each variable for each activity 
  ##and each subject
  final <- fin %>%
    group_by(activity, subject) %>%
    summarize_all(funs(mean))
  ##Creation ends
  
  ##Dump to a file
  write.table(final, file = "tidydata.txt", row.names = FALSE)
}