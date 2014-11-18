Human-Activity-Recognition Code Book
==========================

This file described the source data and the procedure used by the script `run_analysis.R` to generate a tidy dataset named `averaged.data`. A list and description of all variables used in the script is gigen at the end of this document.

## Original data

The data used by the script are data collected from the accelerometers from the Samsung Galaxy S smartphone. They are provided by the UCI machine learning repository, a full description is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. A detailled description of these data can be found in the 'README.txt' file provided with the data.

*For the script to run properly, data have to be downloaded and extracted to a folder named "UCI HAR Dataset" within R's working directory.*

The present analysis do not consider the raw data of the accelerometer (located in the 'Inertial Signals' subfolders). We only use the processed data corresponding to the 561-feature vector with time and frequency domain variables. Furthermore, to create the tidy dataset, we restrict our analysis to the 79 features related to mean or standard deviation (i.e. containing "mean" or "std" in their name). The list of features considered are contained in the character vector 'mean.or.std.features' in the script.

## Transformations

The following describes the procedured used to obtain a tidy dataset from the original data.

### Reading of the source data into test and training dataframes

Reads the input data into the following dataframes:
* `test`
* `training`

Both contain the following variables :
* Subject : a numeric corresponding to the id of the subject (between 1 and 30)
* Activity: a numeric corresponding to the type of activity (between 1 and 6)
* the 561 time and frequency variables, labelled with variables names indicated in activity_labels.txt (in the source data)

Note: For consistency with the description of the original data, the variables names are not changed along the processing (using check.names = FALSE when creating the dataframes).

### Merging of test and training datasets

`test` and `training` datasets are merged (using rbind() command) into a dataframe named `merged.data`. The latter is sorted by Subject id and Activity.

### Restriction to 'mean' and 'std' features

From the `merged.data`, we keep the following variables :
* Subject id
* Activity
* 79 features related to mean or standard deviation values (i.e. containing "mean" or "std" in their name)

Result goes into the `mean.and.std.data` dataframe.

### creation of the tidy dataset 'averaged.data'

From `mean.and.std.data`, we create a independent tidy data set `averaged.data` with the average of each variable for each activity and each subject. This is done using the aggregate() command. The result is sorted by Subject and Activity.


## Summary of all the variables used in the script

* `features.names`: a dataframe, listing the id and names of the 561 measured features (from features.txt). Contains the following columns:
- features id: numeric, id of the variable
- features name: character, name of the feature

* `activity.labels`: a dataframe, listing the id and names of the 6 activities (from activity_labels.txt). Contains the following columns:
- activity id: numeric, id of the activity
- activity name: character, corresponding name of the activity

* `training.subject`: a dataframe, listing the id of subjects for the training dataset (from subject_train.txt). Contains the following column:
- Subject: numeric, id of the subject

* `training.activity`: a dataframe, listing the activity for the training dataset (from y_train.txt). Contains the following column:
- Activity: character, name of the activity

* `training.data`: a dataframe, containing the 561 features for the training dataset (from x_train.txt). Contains 561 columns with names corresponding to `features.names`, all numerics.

* `test.subject`: a dataframe, listing the id of subjects for the test dataset (from subject_test.txt). Contains the following column:
- Subject: numeric, id of the subject

* `test.activity`: a dataframe, listing the activity for the test dataset (from y_test.txt). Contains the following column:
- Activity: character, name of the activity

* `test.data`: a dataframe, containing the 561 features for the test dataset (from x_test.txt). Contains 561 columns with names corresponding to `features.names`, all numerics.

* `training`: a dataframe, combining the subject id, activity, and the 561 features for the training dataset. Contains the following columns:
- Subject:  the subject id
- Activity: the activity id
- 561 columns with names `features.names` giving the features values for each subject and activity.

* `test`: a dataframe, combining the subject id, activity, and the 561 features for the test dataset. Contains the following columns:
- Subject:  the subject id
- Activity: the activity id
- 561 columns with names `features.names` giving the features values for each subject and activity.

* `merged.data`: a dataframe, obtained by merging the `test` and `rtraining` datasets. Contains the following columns:
- Subject:  the subject id
- Activity: the activity id
- 561 columns with names `features.names` giving the features values for each subject and activity.
This dataframe is sorted by subject and activity

*`mean.or.std.features`: a character vector containing the list of features related to a mean or standard deviation measurement.

* `mean.and.std.data`: a dataframe containing the following columns:
- Subject:  the subject id
- Activity: the activity id
- 79 columns with names `mean.or.std.features` giving the features values for each subject and activity (features related to mean or standard deviation measurements).
This dataframe is sorted by subject and activity

* `averaged.data`: a dataframe containing the following columns:
- Subject:  the subject id
- Activity: the activity id
- 79 columns with names giving average of features values by subject and activity (restrictied features related to mean or standard deviation measurements, i.e. `mean.or.std.features`).
This dataframe is sorted by subject and activity






    
    


