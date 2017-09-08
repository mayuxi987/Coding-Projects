library(ggplot2)
library(dplyr)

# set working directory - UPDATE THIS TO YOUR OWN DIRECTORY
setwd('/Users/Yuki/Desktop/SEED/SEEDIE/data/seperate_data/')
# read data and skip the first row with Chinese character
df <- read.csv('PML.csv', skip = 1, stringsAsFactors=F, na.strings=c(""))

# remove empty rows in the end
df <- df[rowSums(is.na(df))==0, ]
#remove columns that is not numeric
df <-df[, sapply(df,is.numeric)==1]

# take all variables/column names
vars <- colnames(df)
# look at the colnames 
vars 

# by comparing with the coding book, get the columns that scaled in 1-5 Likert.
likert_var <- c(vars[2:27])
# turn the vector into dataframe
scale_df <- data.frame(likert_var) 

# count number of missings in each likert variable
scale_df['missing'] <- colSums(df[,likert_var]<0) 
# count number and percentage of each value from 1 to 5
for (i in 1:5) {
  totals <- nrow(df) - scale_df$missing # total count does not include missings
  scale_df[paste('count', i, sep='')] <- colSums(df[,likert_var]==i, na.rm=TRUE)
  scale_df[paste('pct', i, sep='')] <- colSums(df[,likert_var]==i, na.rm=TRUE)/totals
}

# calculate mean
sdf <-df
sdf[sdf<0] <-NA
scale_df['mean'] <- apply(sdf[,likert_var], 2, mean, na.rm=TRUE)
# calculate standard deviation 
scale_df['std'] <- apply(sdf[,likert_var], 2, sd, na.rm=TRUE) 

# plot - tentative, using ggplot2
g <- ggplot(data=scale_df, aes(x=likert_var, y=mean))
g + geom_bar(stat="identity", position=position_dodge(width=0.9)) +
  geom_errorbar(aes(ymin=scale_df$mean-scale_df$std, ymax=scale_df$mean+scale_df$std), 
                position= "dodge", width=0.25) + 
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank(),
        axis.title.x=element_blank())

# generate the result file
write.csv(scale_df,file="C:/Users/Yuki/Desktop/SEED/SEEDIE/basic_analysis/PML_likert.csv",quote = FALSE)
