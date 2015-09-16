# clean up 
rm(list=ls())
# set work directory
setwd('//stat.ad.ncsu.edu/Redirect/zliu15/Desktop/ST Courses/ST512 Lab (TA)/')

# read in 
cig <- read.table('cigarettes.txt', header=T)

# Overview
head(cig)
print(cig)

# Paired scatterplot
pairs(cig[,2:5])

# Outlier
cig[which.max(cig$nicotine),] # delete this obs
cig[which.min(cig$nicotine),] # keep this 

cig <- cig[-3,] # delete the largest one 

# MLR
mlr <- lm(co~tar+nicotine+weight, data=cig)
summary(mlr)

# Prediction
new.data <- data.frame(tar=10, nicotine=0.75, weight=0.9)
predict(mlr, interval="prediction", newdata=new.data, level=0.95)

# SLR
summary(lm(co~tar, data=cig))
summary(lm(co~nicotine, data=cig))
summary(lm(co~weight, data=cig))

# Simulation 
source("lab4_type1.R")
slr.experiment(n.trials=5000,n.data.points=10,slope=0,alpha=.01,equal.variance=TRUE)
slr.experiment(n.trials=5000,n.data.points=10,slope=0,alpha=.01,equal.variance=FALSE)

# Save
save.image("Lab4.RData")