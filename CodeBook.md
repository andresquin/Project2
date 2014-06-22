Source 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Data 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Project Subject :

Wearable Computing

 
1. Merges the training and test sets to create one data set, namely

train/X_train.txt with test/X_test.txt 

2 Reads file features.txt and extracts only the measurements on the mean and standard deviation for each measurement

It's a file type data frame 10299 x 66, measurments with floating points.

3. Use descriptive activity names to name the activities in the data set.

Merge the data with the activity, the activity are the fllowing ones : walking, walkingdownstairs,sitting, standing,
laying

4. Label the data

Use gsub to replace the data as the instructions follow :http://rfunction.com/archives/2354


5. independent tidy data set with the average of each measurement for each activity and each subject.

The code produce as result the avergare of each variable for each activity , and subject. The size is : its compsed by 
6 activites described before and 30 subjects.


