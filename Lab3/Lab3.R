# clean up 
rm(list=ls())
# set work directory
setwd('//stat.ad.ncsu.edu/Redirect/zliu15/Desktop/ST Courses/ST512 Lab (TA)/')

# read in 
enzyme <- read.table('enzyme.txt', header=T)

# overview
head(enzyme)
nrow(enzyme)

# regression
lr <- lm(count~conc,data=enzyme)
summary(lr)

# Scatter plot
plot(enzyme$conc,enzyme$count,xlab='Concentration',ylab='Count')
abline(lr)

# Residual plot
resid(lr)
fitted(lr)
plot(fitted(lr),resid(lr), xlab="Fitted values", ylab="Residuals")  # non-constant variance
abline(h=0,lty="dashed")

# QQ plot
qqnorm(resid(lr))
qqline(resid(lr))

# Re-fit
# regression
lr2 <- lm(log(count)~log(conc),data=enzyme)
summary(lr2)

# Scatter plot
plot(log(enzyme$conc),log(enzyme$count),xlab='Concentration',ylab='Count')
abline(lr2)

# Residual plot
resid(lr2)
fitted(lr2)
plot(fitted(lr2),resid(lr2), xlab="Fitted values", ylab="Residuals")  # non-constant variance
abline(h=0,lty="dashed")

# QQ plot
qqnorm(resid(lr2))
qqline(resid(lr2))

# Prediction
new.data <- data.frame(conc=exp(2.5))
predict(lr2, interval='prediction',newdata=new.data, level=0.95)

# Power calculation
source("lab3_power.R")
slr.experiment(n.trials=5000,n.data.points=10,slope=0,alpha=.05)
slr.experiment(n.trials=5000,n.data.points=50,slope=1,alpha=.05)

# save
save.image("Lab3.R")