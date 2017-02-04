#Open the file
dataset <- read.csv("C:/Users/Yuki/Desktop/LINJUN/2complete.csv", header = TRUE) #!!!!REQUIRE ACTIONS!!!!#
attr(dataset, "names") # get the names of variables

#create variables
id <- dataset$id
classgrp <- dataset$classgrp
classid <- dataset$classid

#create dataset
with(dataset,{
  grpa <- dataset$id
  grpb <- dataset$grpa   #NOTICE:slightly different than other datasets, need to take the SELF-ID into consideration
  grpc <- dataset$grpb
  grpd <- dataset$grpc
  grpe <- dataset$grpd
  grpf <- dataset$grpe
  grpg <- dataset$grpf
  grph <- dataset$grpg
  grpi <- dataset$grph
  grpj <- dataset$grpi
  grpk <- dataset$grpj
  grpl <- dataset$grpk
  grpm <- dataset$grpl
  grpn <- dataset$grpm
  grpo <- dataset$grpn
  grpp <- dataset$grpo
  dataset.0 <<- data.frame(id,grpa,grpb,grpc,grpd,grpe,grpf,grpg,grph,grpi,grpj,grpk,grpl,grpm,grpn,grpo,grpp,classid)
})

with(dataset,{
  grpa <- dataset$grp1a
  grpb <- dataset$grp1b
  grpc <- dataset$grp1c
  grpd <- dataset$grp1d
  grpe <- dataset$grp1e
  grpf <- dataset$grp1f
  grpg <- dataset$grp1g
  grph <- dataset$grp1h
  grpi <- dataset$grp1i
  grpj <- dataset$grp1j
  grpk <- dataset$grp1k
  grpl <- dataset$grp1l
  grpm <- dataset$grp1m
  grpn <- dataset$grp1n
  grpo <- dataset$grp1o
  dataset.1 <<- data.frame(id,grpa,grpb,grpc,grpd,grpe,grpf,grpg,grph,grpi,grpj,grpk,grpl,grpm,grpn,grpo)
  dataset.1[,"grpp"] <- NA
  dataset.1 <<- data.frame(dataset.1,classid)
})

with(dataset,{
  grpa <- dataset$grp2a
  grpb <- dataset$grp2b
  grpc <- dataset$grp2c
  grpd <- dataset$grp2d
  grpe <- dataset$grp2e
  grpf <- dataset$grp2f
  grpg <- dataset$grp2g
  grph <- dataset$grp2h
  grpi <- dataset$grp2i
  grpj <- dataset$grp2j
  grpk <- dataset$grp2k
  grpl <- dataset$grp2l
  grpm <- dataset$grp2m
  grpn <- dataset$grp2n
  grpo <- dataset$grp2o
  dataset.2 <<- data.frame(id,grpa,grpb,grpc,grpd,grpe,grpf,grpg,grph,grpi,grpj,grpk,grpl,grpm,grpn,grpo)
  dataset.2[,"grpp"] <- NA
  dataset.2 <<- data.frame(dataset.2,classid)
})

with(dataset,{
  grpa <- dataset$grp3a
  grpb <- dataset$grp3b
  grpc <- dataset$grp3c
  grpd <- dataset$grp3d
  grpe <- dataset$grp3e
  grpf <- dataset$grp3f
  grpg <- dataset$grp3g
  grph <- dataset$grp3h
  grpi <- dataset$grp3i
  grpj <- dataset$grp3j
  grpk <- dataset$grp3k
  grpl <- dataset$grp3l
  grpm <- dataset$grp3m
  grpn <- dataset$grp3n
  grpo <- dataset$grp3o
  dataset.3 <<- data.frame(id,grpa,grpb,grpc,grpd,grpe,grpf,grpg,grph,grpi,grpj,grpk,grpl,grpm,grpn,grpo)
  dataset.3[,"grpp"] <- NA
  dataset.3 <<- data.frame(dataset.3,classid)
})

with(dataset,{
  grpa <- dataset$grp4a
  grpb <- dataset$grp4b
  grpc <- dataset$grp4c
  grpd <- dataset$grp4d
  grpe <- dataset$grp4e
  grpf <- dataset$grp4f
  grpg <- dataset$grp4g
  grph <- dataset$grp4h
  grpi <- dataset$grp4i
  grpj <- dataset$grp4j
  grpk <- dataset$grp4k
  grpl <- dataset$grp4l
  grpm <- dataset$grp4m
  grpn <- dataset$grp4n
  grpo <- dataset$grp4o
  dataset.4 <<- data.frame(id,grpa,grpb,grpc,grpd,grpe,grpf,grpg,grph,grpi,grpj,grpk,grpl,grpm,grpn,grpo)
  dataset.4[,"grpp"] <- NA
  dataset.4 <<- data.frame(dataset.4,classid)
})

#Delete the missing data
dataset.0 <- dataset.0[with(dataset.0, {
  !(is.na(grpb) )
}), ]

dataset.1 <- dataset.1[with(dataset.1, {
  !(is.na(grpa) )
}), ]

dataset.2 <- dataset.2[with(dataset.2, {
  !(is.na(grpa) )
}), ]

dataset.3 <- dataset.3[with(dataset.3, {
  !(is.na(grpa) )
}), ]

dataset.4 <- dataset.4[with(dataset.4, {
  !(is.na(grpa) )
}), ]

#Combine the datasets
dataset.combine<-rbind.data.frame(dataset.0, dataset.1, dataset.2, dataset.3, dataset.4)
dataset.combine[,1]<- paste("#", sep = "", dataset.combine[,1])


#delete the repeated values 核心思想将data.frame转化为matrix后利用unique函数生成新的matrix。
dataset.matrix<- as.matrix.data.frame(dataset.combine)
initial<- unique(dataset.matrix[1,2:17])
length(initial) <- 16
x <- seq(from = 2, to = 12430, by = 1)
for(i in x){
  trial<-unique(dataset.matrix[i,2:17])
  length(trial) <-16
  initial<- rbind(initial,trial)
}


new.dataset.clear<- cbind(dataset.combine$id,initial,dataset.combine$classid)

#Decide the class you want to handle with
classidTotal <- unique(dataset$classid)
for (i in classidTotal){
  temp <- subset(new.dataset.clear, new.dataset.clear[,18] == i)
  temp.final <- temp[,1:17] 
  write.table(temp.final, file = paste0("C:/Users/Yuki/Desktop/LINJUN/", i, ".txt"), quote = FALSE, na= "", row.names= FALSE, col.names = FALSE)
  }
