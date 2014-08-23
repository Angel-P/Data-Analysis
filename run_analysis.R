library(reshape2)
## READ DATA INTO R 
test.data <- read.csv("./test/X_test.txt", sep ="", header = FALSE)
train.data <- read.csv("./train/X_train.txt", sep="", header = FALSE)
## READ ACTIVITY LABELS INTO R 
test.activity <- read.csv("./test/y_test.txt", sep=" ", header = FALSE)
train.activity <- read.csv("./train/y_train.txt", sep=" " , header = FALSE)
## READ SUBJECT DATA INTO R 
train.subject.data <- read.csv("./train/subject_train.txt", sep = " ", header = FALSE)
test.subject.data <- read.csv("./test/subject_test.txt", sep = " ", header = FALSE)
## READ COLUMN LABELS INTO R 
column.names <- read.csv("./features.txt",sep="-", header = FALSE)
## APPEND COLUMN NAMES TO TEST/TRAIN DATA SETS
colnames(train.data) <- column.names[,1]
colnames(test.data) <- column.names[,1]
## COERCE COLUMN.NAMES INTO CHARACTERS(This was necessary to avoid having
## having R coerce factors into weird numerics. )
column.names <- data.frame(lapply(column.names,as.character), stringsAsFactors=FALSE)
## APPEND DATA TYPE ( mean,st.dev, etc) to data frames for indexing later
test.data <- rbind(test.data,column.names[,2])
train.data <- rbind(train.data,column.names[,2])
## ADDING ONE NA AT THE END OF test.activity/train.activity to keep length =
## this way I can append the activity data after the inclusion of data.type
## variable (mean(),st.dev(), etc)
train.activity[7353,1] <- NA
test.activity[2948,1] <- NA
## APPEND ACTIVITY DATA TO DATA FRAMES
test.data$activity <- c(test.activity[,1])
train.data$activity <- c(train.activity[,1])
## ADDING ONE NA AT THE END OF test.activity/train.activity to keep length =
## this way I can append the activity data after the inclusion of data.type
## variable (mean(),st.dev(), etc)
train.subject.data[7353,1] <- NA
test.subject.data[2948,1] <- NA
## APPEND SUBJECT DATA TO DATA FRAMES
test.data$subject <- c(test.subject.data[,1])
train.data$subject <- c(train.subject.data[,1])
## MERGE THE TWO DATA FRAMES
merged.data <- merge(test.data,train.data, all = TRUE)
## EXTRACT DATA RELATED ONLY TO MEANS AND STD.DEV 
## ***I couldnt find an easier way to do this. Please let me know in comment section
## how to do this more adequately if you can. Thanks!! ***
merged.data.cut <- merged.data[,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,
227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543,562,563)]
## CHANGE FACTOR VARIABLE INTO TEXT
merged.data.cut$activity[merged.data.cut$activity =="1"] <- "WALKING"
merged.data.cut$activity[merged.data.cut$activity =="2"] <- "WALKING UPSTAIRS"
merged.data.cut$activity[merged.data.cut$activity =="3"] <- "WALKING DOWNSTAIRS"
merged.data.cut$activity[merged.data.cut$activity =="4"] <- "SITTING"
merged.data.cut$activity[merged.data.cut$activity =="5"] <- "STANDING"
merged.data.cut$activity[merged.data.cut$activity =="6"] <- "LAYING"
## MELT DATA INTO THIN DATASET
merged.data.melt <- melt(merged.data.cut, id=c("activity","subject"))
## COERCE MELTED DATA INTO NUMERIC TO MAKE COMPUTATIONS POSSIBLE
merged.data.melt$value <- as.numeric(merged.data.melt$value)
## CREATE TIDY DATA FRAME WITH ACTIVITY/SUBJECT PAIRS AND MEANS
tidy <- dcast(merged.data.melt, activity+subject ~ variable,mean)
## CLEAR OUT ROW OF NA's. NOT EXACTLY SURE HOW THIS CAME TO BE
tidy <- tidy[-181,]
## WRITE DATA TO TABLE FOR SUBMISSION
write.table(tidy, file = "./tidy.txt", row.name=FALSE)