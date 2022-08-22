---
output:
  pdf_document: default
  html_document: default
---

# Code Book for Getting and Cleaning Data Course Project

The following steps were followed in the ``run_analysis.R`` script:

* The first step in the ``run_analysis.R`` is downloading and unzipping data to
``UCI HAR Dataset``. This folder contains two files (``activity_labels.txt``, 
and ``features.txt``) and two folders (``test``, and ``train``) that are relevant 
for the project.

* Eight different files were read using ``read.table()`` function into different variables.
  * ``act`` <- ``activity_labels.txt``: 6 rows x 2 cols(code, and activity).
  * ``feat`` <- ``features.txt``: 561 rows x 2 cols(serial, and feature names); the features 
  come from the accelerometer and gyroscope measurements.
  * ``train_subject`` <- ``./train/subject_train.txt``: 7352 rows x 1 col; the index of the subject (between 1-30).
  * ``train_X`` <- ``./train/X_train.txt``: 7352 rows x 561 cols; all the 561 columns correspond to the features (in order) as described in ``features.txt``. The column names were assigned after the ``features.txt`` file.
  * ``train_y`` <- ``./train/y_train.txt``: 7352 rows x 1 col; different activity codes 
   (the corresponding activities are described in ``activity_labels.txt``). 
  * ``test_subject`` <- ``./test/subject_test.txt``: 2947 rows x 1 col; the index of the subject (between 1-30).
  * ``test_X`` <- ``./test/X_test.txt``: 2947 rows x 561 cols; all the 561 columns correspond to the features (in order) as described in ``features.txt``.
  * ``test_y`` <- ``./test/y_test.txt``: 2947 rows x 1 col; different activity codes 
   (the corresponding activities are described in ``activity_labels.txt``). 
   
* The ``train`` and ``test`` data sets are merged using ``bind_rows()`` function into three different variables: ``subject``(10299 x 1), ``X``(10299 x 561), and ``y``(10299 x 1).  The column names containing ``mean`` or ``std`` are selected to be saved in ``X`` using ``select(contains("mean")|contains("std"))`` function yielding ``X``(10299 x 86) with smaller number of columns. The ``subject`` and ``y`` columns are saved in ``fin`` (10299 x 2) using ``bind_cols(subject, y)`` function.  

* Descriptive activity names replaced the ``code`` in ``fin`` by nesting ``mutate(activity = act$activity[code])`` and ``select(-code)``. This is followed by binding ``X`` columns in ``fin`` (10299 x 88).

* Appropriate names were assigned to different columns in ``fin`` by elongating the abbreviated names. The information for elongation was obtained from the ``features.txt`` file and ``gsub()`` function was used in the R script for different abbreviated names.

* The final data was obtained by using nested statements on ``fin``: ``group_by(activity, subject)`` function groups the table by the two variables within the bracket, ``summarize_all(funs(mean))`` takes mean of all the columns corresponding to a particular subject and a particular activity. The ``final``(180 x 88) table is saved in ``tidydata.txt``. 