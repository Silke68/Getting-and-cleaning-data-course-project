# Getting-and-cleaning-data-course-project

The R script "run_analysis.R" does the following:

1. Loads the test and training data set.
2. Adds column names for the different types of measurements.
3. Extracts only the measurements on the mean and standard deviation for each measurement.
4. Merges the training and the test sets to create one data set.
5. Adds a column with the subject ID and another column with the peformed activity using descriptive names.
6. Creates a tidy data set with the average of each variable for each activity and each subject and safes it in the file "tidy_data.txt".
