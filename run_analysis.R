# gets the Samsung data, Merges the training numbers
Y <- rbind(y_train, y_test)
X <- rbind(x_train, x_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

#Extracts  the measurements for mean and s. deviation for each measurement
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))
TidyData$code <- activities[TidyData$code, 2]

# renames the data
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

Enddata <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(Enddata, "Cleanfitbitdata.txt", row.name=FALSE)

