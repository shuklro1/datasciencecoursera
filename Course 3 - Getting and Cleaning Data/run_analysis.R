#Project – cleaning and tidying data

##loading packages
library(data.table)

##Merge the training and the test sets to create one data set and
##appropriately labeling the data set with descriptive variable names.

#reading column names for merged dataset
cl_nm <- read.table(".\\features.txt")


#reading test data
sub_test <- read.table(".\\test\\subject_test.txt")
x_test <- read.table(".\\test\\X_test.txt")
y_test <- read.table(".\\test\\y_test.txt")

#assinging column names to test data sets
colnames(x_test) <- cl_nm$V2
colnames(y_test) <- "activity"
colnames(sub_test) <- "subject"

#merging columns of test dataset
test <- cbind(sub_test,y_test,x_test)

#reading training data
sub_train <- read.table(".\\train\\subject_train.txt")
x_train <- read.table(".\\train\\X_train.txt")
y_train <- read.table(".\\train\\y_train.txt")

#assinging column names to train data sets
colnames(x_train) <- cl_nm$V2
colnames(y_train) <- "activity"
colnames(sub_train) <- "subject"

train <- cbind(sub_train,y_train,x_train) #merging columns of test dataset

comp_dt <- rbind(test,train) #final combined dataset

##Extracting only the columns that have mean and standard deviation for each measurement.

n_col <- colnames(comp_dt)

#getting column names having data for mean, standard deviation, subject and activity
fltr <- grep("mean\\()|std\\()|subject|activity",n_col)

#subsetting combined dataset to have columns related only to mean,
#standard deviation, subject and activity
f_dt <- comp_dt[,fltr]


##Assigning descriptive names to the activities in the data set.

#getting activity labels from activity_labels.txt file
act_lbl <- read.table(".\\activity_labels.txt")

#Converting column "activity" into factor and assigning activity labels to it.
f_dt[,'activity']<-factor(f_dt[,'activity'],labels = act_lbl$V2)

##Creating tidy dataset

melted <- melt(f_dt,id=(1:2),value=(3:68))
tidy_data <- dcast(melted,subject+activity~variable,mean)

write.table(tidy_data,'tidy_data.txt',row.names = F,sep = "\t")

