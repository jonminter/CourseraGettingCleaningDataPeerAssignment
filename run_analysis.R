datasetBasePath = 'UCI HAR Dataset'

# get list of the features of the dataset and determine which ones are either 
# mean or standard deviations of measurements
features <- read.table(paste(datasetBasePath, "/features.txt", sep=""))
featuresToKeep <- features[
	sapply(features$V2, function(x) grepl("(mean\\(\\)|std\\(\\))", x)),
]

# get the descriptive activity names
activityLines <- 
	readLines(paste(datasetBasePath, "/activity_labels.txt", sep=""))
activityLabels = list()
for (line in activityLines) { 
	lineParts <- strsplit(line, ' ')
	activityLabels[lineParts[[1]][1]] <- lineParts[[1]][2]
}

# For both the training and test data sets extract the data we need and create
# data frame with combined data
mergedData <- data.frame()
for (datasetName in c('train','test')) {
	subjectList <- read.table(
		paste(
			datasetBasePath, "/", datasetName, "/subject_", datasetName, ".txt", 
			sep=""
		)
	)
	
	activityList <- read.table(
		paste(
			datasetBasePath, "/", datasetName, "/y_", datasetName, ".txt", 
			sep=""
		)
	)
	
	activitiesLabeled <- sapply(activityList$V1, function(x) activityLabels[[x]])
	
	measurements <- read.table(
		paste(
			datasetBasePath, "/", datasetName, "/X_", datasetName, ".txt", 
			sep=""
		)
	)
	mergedData <- rbind(mergedData, cbind(
		subjectList, activityList, activitiesLabeled,
		measurements[,featuresToKeep$V1]
	))
}

# set the column names
colnames(mergedData) <- 
	c('Subject', 'Activity', 'ActivityName', as.vector(featuresToKeep$V2))

#split along Subject/Activity
splitData <- split(mergedData, list(mergedData$Subject, mergedData$Activity))
