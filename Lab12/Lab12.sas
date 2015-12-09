dm 'log; clear; output; clear'; *Clear windows;
%let path = \\stat.ad.ncsu.edu\Redirect\zliu15\Desktop\ST Courses\ST512 Lab (TA); * macro variable to represent the input path;

/* Read in data */
data wheat;
	infile "&path\wheat.txt" firstobs=2;
	input variety $ field $ fert $ yield;
run;
/* Fit split-plot model*/
proc mixed data=wheat method=type3;
	class variety field fert;
	model yield=variety|fert /ddfm=satterth;
	random field(variety);
	estimate 'Fert A vs B' fert 1 -1/cl; *alpha=0.05 by default;
	*lsmeans fert/cl;
run;

proc mixed data=wheat method=reml;
	class variety field fert;
	model yield=variety|fert /ddfm=satterth;
	random field(variety);
run;

/* Read in data */
data neuralgia;
	infile "&path\neuralgia.txt" firstobs=2;
	input trt $ gender $ age duration pain $ ;
run;
/* Fit logistic regression model*/
proc logistic data=neuralgia;
	class trt gender / param=reference;
	model pain(event='No')=trt gender age duration;
run;

/* Re-fit*/
proc logistic data=neuralgia;
	class trt gender / param=reference;
	model pain(event='No')=trt gender age;
run;
