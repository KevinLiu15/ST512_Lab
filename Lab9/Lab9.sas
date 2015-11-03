dm 'log; clear; output; clear'; *Clear windows;
%let path = \\stat.ad.ncsu.edu\Redirect\zliu15\Desktop\ST Courses\ST512 Lab (TA); * macro variable to represent the input path;

/* Read in data */
data cowdiet;
	infile "&path\cowdiet.txt" firstobs=2;
	input nitrogen $ barley $ intake;
run;

proc print data=cowdiet;
run;

/* Two-factor ANOVA */
proc glm data=cowdiet;
	class nitrogen barley;
	model intake = nitrogen|barley;
run;

/* Multiple testing */
proc glm data=cowdiet;
	class nitrogen barley;
	model intake = nitrogen|barley;
	means barley/tukey;
run;

proc glm data=cowdiet;
	class nitrogen barley;
	model intake = nitrogen|barley;
	means nitrogen/tukey;
run;

/* Estimate the linear combination */
proc glm data=cowdiet;
	class nitrogen barley;
	model intake = nitrogen|barley/clparm;
	estimate 'Difference in the marginal means for the two nitrogen treatments' nitrogen -1 1/e;
run;

/* Read in data */
data ritalin;
	infile "&path\ritalin.txt" firstobs=2;
	input group $ drug $ activity;
run;

/* ANOVA */
proc glm data=ritalin;
	class group drug;
	model activity= group|drug;
run;

/* Estimate the linear combination */
proc glm data=ritalin;
	class group drug;
	model activity= group|drug /clparm alpha=0.1;
	estimate 'Simple effect of Ritalin in ADHD group' drug -1 1 group*drug -1 1 0 0 /e;
run;

proc glm data=ritalin;
	class group drug;
	model activity= group|drug /clparm alpha=0.1;
	estimate 'Simple effect of Ritalin in ADHD group' drug -1 1 group*drug 0 0 -1 1/e;
run;
