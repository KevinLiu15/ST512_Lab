# clean up 
rm(list=ls())
# set work directory
setwd('//stat.ad.ncsu.edu/Redirect/zliu15/Desktop/ST Courses/ST512 Lab (TA)/')

# read in 
baby <- read.table('baby.txt', header=T)

# Overview
head(baby)
unique(baby$smoke)

# SLR
slr <- lm(bwt~gestation,data=baby)
summary(slr)

plot(baby$gestation,baby$bwt,xlab='Gestation', ylab='Baby Weight')
abline(slr)
abline(v=200,col='red',lty='dotted')

# Refit
baby2 <- subset(baby,gestation>200)
slr2 <- lm(bwt~gestation,data=baby2)
summary(slr2)

# MLR
mlr <- lm(bwt~age+height+weight+gestation+smoke,data=baby2)
summary(mlr)

# Categorical predictor with more than 2 levels

# y <- c(2,1,4,5,7)
# x1 <- c(1.3,3.5,3,7,8.9)
# x2 <- c(1,2,3,1,2)
# data <- cbind(y,x1,x2)
# summary(lm(y~x1+factor(x2)))
# x22 <- relevel(factor(x2),ref=2) # Method 1
# summary(lm(y~x1+x22))
# x22 <- C(factor(x2),contr.treatment(3, base=2)) # Method 2
# summary(lm(y~x1+x22))

# Prediction
new.data <- data.frame(age=25, height=68, weight=150, gestation=275, smoke=0)
predict(mlr, interval="prediction", newdata=new.data, level=0.95)

# Matrix
x <- matrix(c(1,1,1,5,10,20),3,2)
y <- c(15,10,5)
beta <- solve(t(x)%*%x)%*%t(x)%*%y # Method 1
beta2 <- solve(crossprod(x),t(x)%*%y) # Method 2
yhat <- x%*%beta
y[1]-yhat[1]

# save
save.image("Lab5.RData")


