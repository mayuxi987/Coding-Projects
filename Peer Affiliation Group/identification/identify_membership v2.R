#File path setting
fph = "C:/Users/Yuki/Downloads/"

dataset_matrix <- read.csv(paste0(fph,"110802_matrix.csv"), header=FALSE)
dataset_matrix <- as.matrix(dataset_matrix)
dataset_matrix[is.na(dataset_matrix)] <-0 ##if the value is NA, then it cannot be added into the equation. for example, NA+5 =NA, no meaning. 
dataset_membership <-read.csv (paste0(fph,"110802_membership.csv"), header = TRUE)

duplicate_over2 <- dataset_membership[duplicated(dataset_membership[,2]),]
duplicate_2<- duplicate_over2[!duplicated(duplicate_over2[,2]),]
duplicate_only3 <-duplicate_over2[duplicated(duplicate_over2[,2]),]
duplicate_only2 <- duplicate_2[!duplicate_2[,2] %in% duplicate_only3[,2],] #to get the students who only belong to 2 groups


# the following is the codes for students who only belong to 2 groups

store.final=data.frame(NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)
colnames(store.final)=NA

for (j in duplicate_only2[,2]) {
  
  groupid_studentid<-subset(dataset_membership, studentid == j)
  group1 <- subset(dataset_membership,groupid== groupid_studentid[1,1])
  group2<-subset(dataset_membership,groupid== groupid_studentid[2,1])
  
  sum1 <-0
    for ( i in group1[,2]) {
    x <- dataset_matrix[which(dataset_matrix[,1]==j),which(dataset_matrix[1,]==i)]
    sum1 <- x + sum1
    }
  
  sum2 <- 0
    for ( k in group2[,2]) {
    y <- dataset_matrix[which(dataset_matrix[,1]==j), which(dataset_matrix[1,]==k)]
    sum2 <- y + sum2
    }
  
  id <- j
  groupid_1 <- group1[1,1]
  number_of_student_1 <-length(group1[,1])
  groupid_2 <- group2[1,1]
  number_of_student_2 <- length(group2[,1])
  
  store_2 <-data.frame(id,groupid_1,sum1,number_of_student_1, groupid_2, sum2,number_of_student_2)
  print(store_2)  # print the needed information for further judgement 
  store_fmt <- data.frame(id,groupid_1,sum1,number_of_student_1, groupid_2, sum2,number_of_student_2,NA,NA,NA)
  colnames(store_fmt)=NA
  store.final<- rbind(store.final,store_fmt)
  
}

# the following is for individuals who belong to 3 groups
for (j in duplicate_only3[,2]) {
  
  
  groupid_studentid<-subset(dataset_membership, studentid == j)
  group1 <- subset(dataset_membership,groupid== groupid_studentid[1,1])
  group2<-subset(dataset_membership,groupid== groupid_studentid[2,1])
  group3<-subset(dataset_membership,groupid== groupid_studentid[3,1])
  
  sum1 <-0
  for ( i in group1[,2]) {
    x <- dataset_matrix[which(dataset_matrix[,1]==j),which(dataset_matrix[1,]==i)]
    sum1 <- x + sum1
  }
  
  sum2 <- 0
  for ( k in group2[,2]) {
    y <- dataset_matrix[which(dataset_matrix[,1]==j), which(dataset_matrix[1,]==k)]
    sum2 <- y + sum2
  }
  
  sum3 <- 0
  for ( l in group3[,2]) {
    z <- dataset_matrix[which(dataset_matrix[,1]==j), which(dataset_matrix[1,]==l)]
    sum3 <- z + sum3
  }
  

  id <- j  # this part is to create the vairable names for the reader to recognize more easily
  groupid_1 <- group1[1,1]
  number_of_student_1 <-length(group1[,1])
  groupid_2 <- group2[1,1]
  number_of_student_2 <- length(group2[,1])
  groupid_3 <-group3[1,1]
  number_of_student_3 <-length(group3[,1])
  
  store_3 <-data.frame(id,groupid_1,sum1,number_of_student_1, groupid_2, sum2,number_of_student_2,groupid_3,sum3,number_of_student_3)
  print(store_3) # print the needed information for futher judgement, if there is no value, meaing that there is no student who belongs to 3 groups
  store_fmt <-data.frame(id,groupid_1,sum1,number_of_student_1, groupid_2, sum2,number_of_student_2,groupid_3,sum3,number_of_student_3)
  colnames(store_fmt)=NA
  store.final<- rbind(store.final,store_fmt)
  
}

colnames(store.final) = c("id" , "groupid_1" , "sum1" , "number_of_student_1" , " groupid_2" , " sum2" , "number_of_student_2" , "groupid_3" , "sum3" , "number_of_student_3")
store.final=store.final[-1,]
write.table(store.final, file = paste0(fph,"110802result.csv"), sep = "," , na= "", row.names= FALSE, col.names = TRUE)