library("dplyr")
#---------------------Step 1 (merge the sets)----------------------------------------------------
#
# Load the training data
#
train_subjects<-read.table("train/subject_train.txt")
train_activities<-read.table("train/y_train.txt")
train_features<-read.table("train/X_train.txt")

#
# Load the test data
#
test_subjects<-read.table("test/subject_test.txt")
test_activities<-read.table("test/y_test.txt")
test_features<-read.table("test/X_test.txt")

#
# Make one dataframe of the training data
#
train<-cbind(train_subjects,train_activities,train_features)

#
# Make one dataframe of the test data
#
test<-cbind(test_subjects,test_activities,test_features)

#
# merge into one dataframe
#
merged<-rbind(train,test)

#
#clear the stuff we don't need anymore
#
rm("train_subjects")
rm("train_activities")
rm("train_features")
rm("test_subjects")
rm("test_activities")
rm("test_features")
rm("train")
rm("test")


#------------------Step 2 and 4 (label the columns and select only std() and mean() ----------
#
# Get the column names into a vector
#

feature_labels=read.table("features.txt",stringsAsFactor=F)
#
# Set the column names
# 
names(merged)[3:563]<-feature_labels[,2]
names(merged)[1]<-"Subject"
names(merged)[2]<-"Activity"

#
# Only need the mean, find the labels with mean()
# (if also meanFreq() could just grep for mean)
#
mean_labels<-feature_labels[grep("mean()",feature_labels[,2]),2]

#
# same trick for std()
#
std_labels<-feature_labels[grep("std()", feature_labels[,2]),2]

#
#subset and assign the subsetted dataframe
#
merged<-merged[c("Subject","Activity",mean_labels,std_labels)]

#
# Cleanup
#
rm("feature_labels")
rm("mean_labels")
rm("std_labels")


#-----------------Step 3 (Use words instead of numbers in the Activity Column) ------------------
#
#Relabel the activities from numbers to text"
#First load the labels
#
activity_labels<-read.table("activity_labels.txt", stringsAsFactors=F)

#
# Need only the names vector
# 
#
activity_labels<-activity_labels[,2]

#
# activity_labels[merged$Activity] is the vector with all activity names
# assing in to Activitiy colum of the dataframe
#

merged$Activity<-activity_labels[merged$Activity]

#
# Cleanup
#
rm("activity_labels")

#------------------Step 5 (Create summarized data) -----------------------------------------------
# Almost Done...
# Convert merged to tbl_df
#

mrg<-tbl_df(merged)

#
# Group by Subject and Activity
#
grp<-group_by(mrg,Subject,Activity)

#
# MAgic trick :-) use the summarize_each function to calculate the means over all columns
#

res<-summarise_each(grp,funs(mean))

#
# Set the variable names
# (prefix with Avg_)
#
names(res)[3:length(names(res))]<-paste0('Avg_',names(res)[3:length(names(res))])

#
#Want to see res on the console
#
print (res)

#
# write the dataset out to file
#

write.table(res,file="result.txt", row.names=F)

#
#done (yeah!)
#
rm("merged")
rm("mrg")
rm("grp")

#We will leave (res) in the environment






