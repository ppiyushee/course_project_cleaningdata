- 	In this Project we are creating a R script run_analysis.R to create two tidy data sets.

-	Environment Set Up 
	
	- In the first step , folowing files used as inputs for run_analysis.R are collected and kept it in one directory.
		X_train.txt ,
		X_test.txt ,
		features.txt ,
		y_train.txt ,
		y_test.txt ,
		activity_labels.txt ,
		subject_train.txt ,
		subject_test.txt ,
	
	- R script run_analysis.R also in the same directory. 

	- run_analysis.R script uses the files above as inputs and creates the following output files in the same directory
		tidy_data_set_1.txt ,
		tidy_data_set_2.txt , 
		Codebook.txt
 

-	How to Run the R Script - run_analysis.R

	- set working directory > setwd("working directory")
	
	- run command > source("run_analysis.R")	

	- the step above will create 3 filed in the working directory

		tidy_data_set_1.txt - file with subject,descritive activity name and all the mean() and std() measurement columns
		tidy_data_set_2.txt - file with subject,descritive activity name and average of all columns in tidy_data_set_1.txt for each subject and each activity
		Codebook.txt - contains columns names for tidy_data_set_2.txt 

-	How run_analysis.R works?
		
	- First it merges the training and test sets to create one data set.
	- Extracts only the measurement on the mean() and std() from the data set using the indexes of mean() and std() measurements from features.txt
	- Modify the columnnames from substituting mean() with mean and std() with std.
	- Creates actvities column with descriptive activities names.
	- Creates subject column with subjet names.
	- Creates first tidy data set (data tidy_data_set_1.txt) by column binding  subject , activity and data set with only mean() and std() measurements.
	- And lastly, it creates a second, independent tidy data set (tidy_data_set_2.txt) with the average of each variables/columns for each subject and each activity from.