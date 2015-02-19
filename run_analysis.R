#Read in the files into dataframes

#Assumes the file has been downloaded into a folder 
#named "uci_data" under your working directory
subjectTrainData <- read.table(".\\uci_data\\train\\subject_train.txt",header = FALSE)
yTrainData <- read.table(".\\uci_data\\train\\y_train.txt",header = FALSE)
xTrainData <- read.table(".\\uci_data\\train\\X_train.txt",header = FALSE)
head(subjectTrainData)
head(yTrainData)
head(xTrainData)

subjectTestData <- read.table(".\\uci_data\\test\\subject_test.txt",header = FALSE)
yTestData <- read.table(".\\uci_data\\test\\y_test.txt",header = FALSE)
xTestData <- read.table(".\\uci_data\\test\\X_test.txt",header = FALSE)
head(subjectTestData)
head(yTestData)
head(xTestData)

featuresData <- read.table(".\\uci_data\\features.txt",header = FALSE)
head(featuresData)

#cbind subjecTrain,yTrain and xTrainData

subjectActivityTrainData <- cbind(subjectTrainData,yTrainData)
combinedTrainData <- cbind(subjectActivityTrainData,xTrainData)
combinedTrainData[1:10,1:10]
nrow(combinedTrainData)
#summary(combinedTrainData)

subjectActivityTestData <- cbind(subjectTestData,yTestData)
combinedTestData <- cbind(subjectActivityTestData,xTestData)
combinedTestData[1:10,1:10]
nrow(combinedTestData)

#rbind combinedTrain and combedTest
combinedData <- rbind(combinedTrainData,combinedTestData)
combinedData[1:10,1:10]
nrow(combinedData)

#Search features dataframe for rows with mean() and std() in it
featureSubset <- grep("mean|std\\(\\)",featuresData$V2)
featureSubset <- featureSubset + 2
addRows <- c(1,2)
newfeatureSubset <- c(addRows,featureSubset)
class(newfeatureSubset)
length(newfeatureSubset)
subsetData <- combinedData[newfeatureSubset]
dim(subsetData)
subsetData[1:10,1:10]

#Replace Activity Numbers with Activity Names in each row of combined dataset
subsetData[subsetData$V1.1 == 1,2]<- "WALKING"
subsetData[subsetData$V1.1 == 2,2]<- "WALKING_UPSTAIRS"
subsetData[subsetData$V1.1 == 3,2]<- "WALKING_DOWNSTAIRS"
subsetData[subsetData$V1.1 == 4,2]<- "SITTING"
subsetData[subsetData$V1.1 == 5,2]<- "STANDING"
subsetData[subsetData$V1.1 == 6,2]<- "LAYING"

dim(subsetData[subsetData$V1.1 == "STANDING",])

#Label the data set with descriptive variable names
#Create a columnNames character vector and set to column names of subsetData
#using the names() command

#featuresData[featureSubset,featuresData$V2]
columnNames <- featuresData[featureSubset-2,2]
charcolumnNames <- as.character(columnNames)
addNameRows <- c("Subject", "Activity")
newcolumnNames <- c(addNameRows,charcolumnNames)
names(subsetData) <- newcolumnNames
head(subsetData)

#Create a second tiny independent data set with an average of each variable 
#for each activity and each subject.
#Use reshape2 to melt the dataset and recast it
library(reshape2)
subsetDataMelt <- melt(subsetData,id=addNameRows, measure.vars=columnNames)
dim(subsetDataMelt)
head(subsetDataMelt)

meanSubjectData <- dcast(subsetDataMelt,Subject ~ variable, mean)
dim(meanSubjectData)
head(meanSubjectData)
meanActivityData <- dcast(subsetDataMelt,Activity ~ variable, mean)
dim(meanActivityData)
head(meanActivityData)

#Write the output data to a txt file
write.table(meanSubjectData, ".\\uci_data\\mean_SubjectData.txt", sep="\t", row.name=FALSE) 
write.table(meanActivityData, ".\\uci_data\\mean_ActivityData.txt", sep="\t", row.name=FALSE) 
