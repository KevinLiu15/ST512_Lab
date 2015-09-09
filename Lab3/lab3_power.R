slr.experiment<-function(n.trials=100,n.data.points=10,slope=0,alpha=.05){
  # This function simulates datasets for a regression model.  
  # Each simulated data set is used to test the
  # null hypothesis H0:beta1=0 against the two-sided alternative.
  # The significance level of the test is determined by the user.

  # The parameters of this function are:
  #
  # n.trials: The number of simulated data sets.  Default is 100.
  # n.data.points: The number of data points in each simulated data set.  
  #    Default is 10.
  # slope: The true slope (an unknown parameter).  Default is 0.
  # alpha: The significance level of the test.  Default is 0.05.
  
  p.values<-double(n.trials) 
  
  # 'p.values' is the name of a vector that will store the simulated p-values.    
  # This command sets aside memory for this vector. 
  
  for(i.trial in 1:n.trials){    # start a loop
    x.values <- seq(from=0,to=1,length=n.data.points)  
    # generate values of the predictor 
    
    errors <- rnorm(n.data.points,sd=1)
    # generate the errors 
     
    y.values=1 + slope * x.values + errors
    # make values of the response by adding 1 + slope * x to the errors
    
    slr<-lm(y.values~x.values)
    # fit a linear regression model to the simulated data
    
    my.p <- summary(slr)$coefficients[2,4]
    # extract the p-value from the regression model (this syntax is complicated)
    
    p.values[i.trial] <- my.p
    # store the p-value in the vector that will hold the results
    
  } # now repeat the body of the 'for loop' until all simulated data sets 
  # have been analyzed
  
  hist(p.values,breaks=seq(0,1,by=.05),main="Histogram of simulated p-values")
  # make a histogram of all the p.values from your test of Ho_beta1=0
  abline(v=alpha,col="red")
  # add a red line to separate the cases where the null hypothesis is rejected
  
  # print a description of the experiment
  print(paste("This experiment consisted of",n.trials,"data sets, each of which included",n.data.points,"data points."))
  print(paste("The true regression slope is",slope))
    
  if(min(p.values)<alpha){
    number.reject <- table(p.values<alpha)[[2]] 
    # count the number of times that the null hypothesis would be rejected 
    # with alpha-level test.  (Again, the syntax is complicated.)
  
    print(paste("The null hypothesis was rejected in",number.reject,"of",n.trials,"simulated data sets using a",alpha,"significance-level test."))}
  else
    # null hypothesis was never rejected
    print(paste("The null hypothesis was rejected in 0 of",n.trials,"simulated data sets using a",alpha,"significance-level test.")) 
}

  	