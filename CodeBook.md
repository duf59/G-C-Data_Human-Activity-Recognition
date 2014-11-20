---
output: html_document
---
Human-Activity-Recognition Code Book
==========================

This file described the source data and the procedure used by the script `run_analysis.R` to generate a tidy dataset named `averaged.data`. A list and description of all variables used in the script is given at the end of this document.

## Original data

The data used by the script are data collected from the accelerometers from the Samsung Galaxy S smartphone. They are provided by the UCI machine learning repository, a full description is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. A detailled description of these data can be found in the 'README.txt' file provided with the data.

*For the script to run properly, data have to be downloaded and extracted to a folder named "UCI HAR Dataset" within R's working directory.*

The present analysis do not consider the raw data of the accelerometer (located in the 'Inertial Signals' subfolders). We only use the processed data corresponding to the 561-feature vector with time and frequency domain variables. Furthermore, to create the tidy dataset, we restrict our analysis to the 79 features related to mean or standard deviation (i.e. containing "mean" or "std" in their name). The list of features considered are contained in the character vector 'mean.or.std.features' in the script.

## Transformations

The following describes the procedure used to obtain a tidy dataset from the original data.

1* **Read the source data into test and training dataframes**

Reads the input data corresponding to the training and test sets into two dataframes named  `training` and `test` respectively.
Each dataframe contains the following informations :
-first column : a numeric corresponding to the id of the subject (between 1 and 30)
-second column: a numeric corresponding to the type of activity (between 1 and 6)
-next columns : the 561 time and frequency variables

2* **Merge the training and the test datasets to create one data set**

`test` and `training` datasets are merged using rbind() to create a dataframe named `merged.data`, the latter containing measurements for all subjects.

3* **Label the data set with descriptive variable names**

Reads the feature names from the features.txt source file. We adjust the names to ensure that they are syntactically valid, remove duplicated words in names, and make some abbreviations more explicit:
- "-" are replaced with "."
- "()" are removed
- "BodyBody" simplified to "Body"
- "Acc" is changed to Acceleration
- "Mag" is changed to Magnitude

"SubjectID" is used as label for the first column of `merged.data`, "Activity" for the second column, and the corrected features names for the 561 other variables.

4* **Extracts only the measurements on the mean and standard deviation**

We subset the `merged.data` dataframe, keeping the following variables :
- SubjectID
- Activity
- 79 features related to mean or standard deviation values

Result goes into the `mean.and.std.data` dataframe.

5* **creation of the tidy dataset**

From `mean.and.std.data`, we create a independent tidy data set `averaged.data` with the average of each variable by subject and activity. This is done using the aggregate() command. `averaged.data` is also sorted by SubjectID and Activity. We also add the prefix "Mean.Of." to all the features names in this dataset in order to distinguish them from the previous datasets.

This final tidy dataset is written into a text file named "tidy.txt". One can read this file and display it in R using :
```
data <- read.table("tidy.txt", header = TRUE, check.names = FALSE)
View(data)
```

## Detailled description of the tidy dataset

The tidy dataset `averaged.data` contains the following variables :

* SubjectID: a numeric corresponding to the ID of the subject, from 1 to 30
* Activity: The activity performed by the subject, there are 6 different activities
* 79 variables based on the following signals :


| Signal                         | Description                                                                | Unit          |
|--------------------------------|----------------------------------------------------------------------------|---------------|
|tBodyAcceleration-XYZ           | Body linear acceleration, X, Y and Z components                            | $m.s^{-2}$    |
|tGravityAcceleration-XYZ        | Gravity linear acceleration, X, Y and Z components                         | $m.s^{-2}$    |
|tBodyAccelerationJerk-XYZ       | Time derivative of Body linear acceleration, X, Y and Z components         | $m.s^{-3}$    |
|tBodyGyro-XYZ                   | Body angular velocity, X, Y and Z components                               | $rad.s^{-1}$  |
|tBodyGyroJerk-XYZ               | Time derivative of body angular velocity, X, Y and Z components            | $rad.s^{-2}$  |
|tBodyAccelerationMagnitude      | Magnitude of body acceleration signals calculated using Euclidean norm     | $m.s^{-2}$    |
|tGravityAccelerationMagnitude   | Magnitude of gravity acceleration signals calculated using Euclidean norm  | $m.s^{-2}$    |
|tBodyAccelerationJerkMagnitude  | Magnitude of tBodyAccelerationJerk signals calculated using Euclidean norm | $m.s^{-3}$    |
|tBodyGyroMagnitude              | Magnitude of Body angular velocity signals calculated using Euclidean norm | $rad.s^{-1}$  |
|tBodyGyroJerkMagnitude          | Magnitude of tBodyGyroJerk signals calculated using Euclidean norm         | $rad.s^{-2}$  |
|fBodyAcceleration-XYZ           | FFT of tBodyAcceleration, X, Y and Z components                            | $m.s^{-2}$    |
|fBodyAccelerationJerk-XYZ       | FFT of tBodyAccelerationJerk, X, Y and Z components                        | $m.s^{-3}$    |
|fBodyGyro-XYZ                   | FFT of tBodyGyro, X, Y and Z components                                    | $rad.s^{-1}$  |
|fBodyAccelerationMagnitude      | Magnitude of fBodyAcceleration signals calculated using Euclidean norm     | $m.s^{-2}$    |
|fBodyAccelerationJerkMagnitude  | Magnitude of fBodyAccelerationJerk signals calculated using Euclidean norm | $m.s^{-3}$    |
|fBodyGyroMagnitude              | Magnitude of fBodyGyro signals calculated using Euclidean norm             | $rad.s^{-1}$  |
|fBodyGyroJerkMagnitude          | Magnitude of fBodyGyroJerk signals calculated using Euclidean norm         | $rad.s^{-2}$  |

First letter t and f describes time or frequency signal respectively.

For time signals, mean and standard deviations are computed, adding the suffix ".mean" or ".std" to the signal name.

For frequency signals, in addition to mean and std, weighted average of the frequency components is computed to obtain a mean frequency, resulting in a variable named with a suffix ".meanFreq".

The above signals containing "XYZ" contains 3 components distinguished by adding suffix ".X", ".Y" or ".Z".

Finally, prefix "Mean.Of." is added to all the variables of the tidy dataset, because they are averaged over several observation of given (SubjectID,Activity) pairs.

As an example, for the Body linear acceleration, which is a time signal, 6 values are computed (mean and std for X, Y and Z components). Following the above convention, they are named: 

"Mean.Of.tBodyAcceleration.mean.X"               
"Mean.Of.tBodyAcceleration.mean.Y"               
"Mean.Of.tBodyAcceleration.mean.Z"               
"Mean.Of.tBodyAcceleration.std.X"                
"Mean.Of.tBodyAcceleration.std.Y"                
"Mean.Of.tBodyAcceleration.std.Z" 

For the FFT signal of Body Acceleration, a frequency signal, 9 variables are computed (mean, std and meanFreq, for X, Y and Z component) :

"Mean.Of.fBodyAcceleration.meanFreq.X"           
"Mean.Of.fBodyAcceleration.meanFreq.Y"           
"Mean.Of.fBodyAcceleration.meanFreq.Z"           
"Mean.Of.fBodyAccelerationJerk.mean.X"           
"Mean.Of.fBodyAccelerationJerk.mean.Y"           
"Mean.Of.fBodyAccelerationJerk.mean.Z"           
"Mean.Of.fBodyAccelerationJerk.std.X"            
"Mean.Of.fBodyAccelerationJerk.std.Y"            
"Mean.Of.fBodyAccelerationJerk.std.Z" 

The tidy dataset is sorted by SubjectID and Activity, it contains 180 rows (30 subjects * 6 activities)

