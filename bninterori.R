fx = as.matrix(fx);
fp = ncol(fx);
fn = nrow(fx);
ones = rep(1, fn);
tempdev0 = NULL  ;
tempmycoef = NULL ;

for (i in 1:fp) {
  tempglmfit = glm.fit(cbind(ones, fx[, i]), fy, family = family)
  tempdev0[i] = tempglmfit$deviance
  tempmycoef[i] = coef(tempglmfit)[2]
}
rank.method='coeff';
used.dev = switch(rank.method, obj = tempdev0, coeff = -abs(tempmycoef))
tempdev0.sort = sort(used.dev, method = "sh", index = TRUE)
initRANKorder = tempdev0.sort$ix;
for (im in fs:nsis){
  if (length(setdiff(1:fs, initRANKorder[1:im]))==0)
  {mleSIS.ori[ip] = im; break;}
}

rank.method='obj';
used.dev = switch(rank.method, obj = tempdev0,
                  coeff = -abs(tempmycoef));
tempdev0.sort = sort(used.dev, method = "sh",index = TRUE);
initRANKorder = tempdev0.sort$ix;
for (im in fs:nsis){
  if (length(setdiff(1:fs, initRANKorder[1:im]))==0)
  {mrSIS.ori[ip] = im; break;}
}