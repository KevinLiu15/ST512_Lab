# clean up 
rm(list=ls())
# set work directory
setwd('//stat.ad.ncsu.edu/Redirect/zliu15/Desktop/ST Courses/ST512 Lab (TA)/')

# read in 
body <- read.table('body.txt', header=T)

# overview
head(body)
summary(body)
nrow(body)
# regression
lr <- lm(weight~height,data=body)
summary(lr)
# Confidence interval for estimate
est <- lr$coefficients[2] # coefficient estimates
se <- sqrt(diag(vcov(lr)))[2] # standard error of estimates
critic <- qt(0.025,df=nrow(body)-2,lower.tail=F) # critic value
c(est-critic*se, est+critic*se) # CI
# P-value in Q3
obs_stat <- (est-1)/se
2*pt(obs_stat, df=nrow(body)-2, lower.tail=F) # p-value

# Prediction
new.data <- data.frame(height=180)
predict(lr, interval='prediction', newdata=new.data, level=0.95)
predict(lr, interval='confidence', newdata=new.data, level=0.95)

# Change of units
body$weight2 <- body$weight*2.2
body$height2 <- body$height/2.54
summary(body)
lr2 <- lm(weight2~height2,data=body)
summary(lr2)

# New data 
president <- read.table("president.txt",header=T)
head(president)
lr3 <- lm(share ~ approval, data=president)
plot(share ~ approval, data=president)

new <- data.frame(approval=55)
predict(lr3, interval='prediction',newdata=new, level=0.95)

# Save
# save.image(file='Lab2.RData')