# Data Cleaning Course Project

**Project Instructions**

1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


**Logical Steps**

*	Read txt files using read.table
*	Cbind x,y and subject files for train and test
*	Rbind train and test 
*	Subset combined dataset based on mean() and std() columns
	* Create feature subset vector from features.txt using grep for mean() and std()
	* Add 2 columns for Subject and Activity
	* Use feature subset vector to subset combined dataset
*   Replace Activity Numbers with Activity Names in each row of combined dataset
*	Label the data set with descriptive variable names
	* Create a columnNames character vector and set to column names of subsetData using the names() command
*	Create a second tiny independent data set with an average of each variable for each activity and each subject.
	* Use reshape2 to melt the dataset and recast it

