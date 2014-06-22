1	+	
2	+	#Set directory
3	+	
4	+	setwd("C:/Users/admin/Documents/project/UCI HAR Dataset")
5	+	
6	+	# Read  files
7	+	features = read.table('./features.txt',header=FALSE); #imports features.txt
8	+	activityType = read.table('./activity_labels.txt',header=FALSE); #imports activity_labels.txt
9	+	subjectTrain = read.table('./train/subject_train.txt',header=FALSE); #imports subject_train.txt
10	+	xTrain = read.table('./train/x_train.txt',header=FALSE); #imports x_train.txt
11	+	yTrain = read.table('./train/y_train.txt',header=FALSE); #imports y_train.txt
12	+	
13	+	# Assigin  names to each column  the data imported above
14	+	colnames(activityType) = c('activityId','activityType');
15	+	colnames(subjectTrain) = "subjectId";
16	+	colnames(xTrain) = features[,2];
17	+	colnames(yTrain) = "activityId";
18	+	
19	+	# final training set by merging yTrain, subjectTrain, and xTrain
20	+	trainingData = cbind(yTrain,subjectTrain,xTrain);
21	+	
22	+	# Read in the test data
23	+	subjectTest = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt
24	+	xTest = read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
25	+	yTest = read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt
26	+	
27	+	colnames(subjectTest) = "subjectId";
28	+	colnames(xTest) = features[,2];
29	+	colnames(yTest) = "activityId";
30	+	
31	+	
32	+	# Create the final test set by merging the xTest, yTest and subjectTest data
33	+	testData1 = cbind(yTest,subjectTest,xTest);
34	+	
35	+	
36	+	# Combine training and test data to create a final data set
37	+	finalData = rbind(trainingData,testData);
38	+	
39	+	# Create a vector for the column names from the finalData, which will be used
40	+	# to select the desired mean() & stddev() columns
41	+	colNames = colnames(finalData);
42	+	
43	+	# 2.The measurements on the mean and standard deviation for each measurement.
44	+	
45	+	# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others
46	+	logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));
47	+	
48	+	# Subset finalData table based on the logicalVector to keep only desired columns
49	+	finalData = finalData[logicalVector==TRUE];
50	+	
51	+	# 3. Use descriptive activity names to name the activities in the data set
52	+	
53	+	# Merge the finalData set with the acitivityType table to include descriptive activity names
54	+	finalData = merge(finalData,activityType,by='activityId',all.x=TRUE);
55	+	
56	+	# Updating the colNames vector to include the new column names after merge
57	+	colNames = colnames(finalData);
58	+	
59	+	# 4. Appropriately label the data set with descriptive activity names.
60	+	
61	+	# Cleaning up the variable names
62	+	for (i in 1:length(colNames))
63	+	{
64	+	  colNames[i] = gsub("\\()","",colNames[i])
65	+	  colNames[i] = gsub("-std$","StdDev",colNames[i])
66	+	  colNames[i] = gsub("-mean","Mean",colNames[i])
67	+	  colNames[i] = gsub("^(t)","time",colNames[i])
68	+	  colNames[i] = gsub("^(f)","freq",colNames[i])
69	+	  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
70	+	  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
71	+	  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
72	+	  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
73	+	  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
74	+	  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
75	+	  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
76	+	};
77	+	
78	+	# Reassigning the new descriptive column names to the finalData set
79	+	colnames(finalData) = colNames;
80	+	
81	+	
82	+	#------------------------------------------------------------------
83	+	# 5.  TIDY DATA set with the average of each variable for each activity and each subject.
84	+	
85	+	#---------------------------------------------------------------------
86	+	
87	+	# Create a new table, finalDataNoActivityType without the activityType column
88	+	finalDataNoActivityType = finalData[,names(finalData) != 'activityType'];
89	+	
90	+	# Summarizing the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject
91	+	tidyData = aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean);
92	+	
93	+	# Merging the tidyData with activityType to include descriptive acitvity names
94	+	tidyData = merge(tidyData,activityType,by='activityId',all.x=TRUE);
95	+	
96	+	# Export the tidyData set
97	+	write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');
98	 	 No newline at end of file
99	 	
