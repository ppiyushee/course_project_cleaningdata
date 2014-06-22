#Merges the training and the test sets to create one data set - total_input_data_set, by using rbind function
  ###read training set X values
  ###read test set X values
  ###row bind training and test set

  train_set <- read.table("X_train.txt")                                           
  test_set  <- read.table("X_test.txt")                                             
  total_input_data_set  <- rbind(train_set, test_set)                             
  
#Create data set with only the measurements on the mean() and std() for each measurement. 
  ###Get indexex for mean() and std() measurement/features from features.txt
  ###Use those indexes to extract the columns from total_input_data_set and create new data set mean_std_input_data_set
  ###Set the columns names of mean_std_input_data_set with mean() and std() measurements ones

  features_set <- read.table("features.txt")
  indexes_for_mean_std <- grep("mean\\(\\)|std\\(\\)", features_set[,2])
  mean_std_input_data_set <- total_input_data_set[, indexes_for_mean_std]              
  updated_features_set <- gsub("\\(\\)", "", features_set[indexes_for_mean_std,2]) 
  names(mean_std_input_data_set) <- updated_features_set                          

#Create descriptive activity names for the data set and name the column as "activity" 

  train_set_activity <- read.table("y_train.txt")
  test_set_activity <- read.table("y_test.txt")
  total_input_data_set_activity <- rbind(train_set_activity, test_set_activity)
  activity_labels <- read.table("activity_labels.txt")
  activity <- activity_labels[total_input_data_set_activity[,1], 2]
  total_input_data_set_activity[,1] <- activity
  names(total_input_data_set_activity) <- "activity"

#Create subjects for the data set and name the column as "subject" 

  train_set_subject <- read.table("subject_train.txt")
  test_set_subject <- read.table("subject_test.txt")
  total_input_data_set_subject <- rbind(train_set_subject, test_set_subject )
  names(total_input_data_set_subject) <- "subject"


#Create first tidy data tidy_data_set_1 and write it to a file tidy_datat_set_1.txt
  ###Column bind subject data set , activity data set and mean_std_input_data_set
  ###write the data frame to a file 

  tidy_data_set_1 <- cbind(total_input_data_set_subject,total_input_data_set_activity, mean_std_input_data_set )
  write.table(tidy_data_set_1, "tidy_data_set_1.txt", row.names=FALSE)

#Creating a data set and file of mean of every variable for each subject and each activity from the first data set tidy_data_set_1
#Write the data set/frame to tidy_data_set_2.txt
#Write the column names in Codebook.txt  
  
  sub_vect <- sort(unique(tidy_data_set_1$subject))
  sub_len <- length(sub_vect)
  act_vect <- sort(unique(tidy_data_set_1$activity))
  act_len <- length(act_vect)
  col_len  <- dim(tidy_data_set_1)[2]

  temp <- matrix(NA, nrow = sub_len * act_len, ncol = col_len)
  tidy_data_set_2 <- as.data.frame(temp)                                    #Initialize the second tidy data set with NAs
  names(tidy_data_set_2) <- gsub("^", "Average_", names(tidy_data_set_1))   #Prefix Columns Names of with second tidy data "Average_" string
  names(tidy_data_set_2)[1] <- "subject"                                    #Rename first column back to "subject"
  names(tidy_data_set_2)[2] <- "activity"                                   #Rename second column back to "activity"

  row_num <- 1
  for (i in 1:length(sub_vect)) {
      for (j in 1:length(act_vect)) {
          tidy_data_set_2[row_num, 1] <-    sub_vect[i]
          tidy_data_set_2[row_num, 2] <-    act_vect[j]
          flag_1 <- sub_vect[i] == tidy_data_set_1$subject
          flag_2 <- act_vect[j] == tidy_data_set_1$activity
          tidy_data_set_2[row_num, 3:col_len] <- colMeans(tidy_data_set_1[flag_1 & flag_2, 3:col_len])
          row_num <- row_num + 1
      }
  }
write.table(tidy_data_set_2, "tidy_data_set_2.txt", row.names=FALSE)
write.table(names(tidy_data_set_2), "Codebook.txt", quote=FALSE, col.names=FALSE)  
