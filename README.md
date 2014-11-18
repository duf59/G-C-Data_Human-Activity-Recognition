Human-Activity-Recognition
==========================

This repository contains material for the course project of the Coursera course "Getting and Cleaning Data", part of the Data Science specialization. The overall aim of this project is to write an R script generating a tidy dataset from raw data, along with a CodeBook describing the variables, the data, and the transformations performed to clean up the data.

The data used for this project are data collected from the accelerometers from the Samsung Galaxy S smartphone. They are provided by the UCI machine learning repository, a full description is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Content

* `run_analysis.R`: the R script
* `Readme.md`: the actual readme file
* `CodeBook.md`: the code book describing the variables, data and transformations performed to obtain a tidy dataset

## Pre-requisite

The R script does not include code to download the source data. The latter are described and can be obtained [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). They can also be downloaded directly from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

**For the `run_analysis.R` script to run properly, data have to be downloaded and extracted to a folder named "UCI HAR Dataset" within R's working directory.**

## Notes

* The script only uses the base R package