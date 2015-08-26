# clean up 
rm(list=ls())
# see current directory
getwd()
# set work directory
setwd('Z:/Desktop/ST Courses/ST512 Lab (TA)/')

# read in 
body <- read.table('body.txt', header=T)
# overview
head(body)
dim(body)
ls()
summary(body) # basic statistcs
mean(body$age) # or mean(body[,1])
var_height <- var(body$height) # var(body[,3])
sqrt(var(body$weight))
cor(body$height,body$weight)
sqrt(var_height/nrow(body)) # key to Q6
males_gr <- body[body$gender=="Male",]
colnames(males_gr)
mean(males_gr$height)
# scatterplot
stripchart(body$height ~ body$gender, method="jitter")
# t-test
t.test(height~gender,data=body)
# regression
plot(weight~height,data=body)
lr <- lm(weight~height,data=body)
summary(lr)
abline(lr)

#save
save.image(file='Lab1.RData')

