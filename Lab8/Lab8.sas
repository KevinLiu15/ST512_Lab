dm 'log; clear; output; clear'; *Clear windows;
%let path = \\stat.ad.ncsu.edu\Redirect\zliu15\Desktop\ST Courses\ST512 Lab (TA); * macro variable to represent the input path;

/* Read in data */
data clover;
	infile "&path\clover.txt" firstobs=2;
	input strain $ nitrogen;
run;

proc print data=clover;
run;

/* Scatterplot */
proc gplot data=clover;
	plot strain*nitrogen;
run;

/* ANOVA */
proc glm data=clover;
	class strain (ref='Composit');
	model nitrogen=strain / solution;
run;

/* Estimate the linear combination */
proc glm data=clover;
	class strain;
	model nitrogen=strain/clparm alpha=0.1;
	estimate 'avg of K1-K5 vs Composite' strain -5 1 1 1 1 1/ divisor=5 e;
run;

/* Multiple testing */
proc glm data=clover;
	class strain;
	model nitrogen=strain;
	means strain/bon lsd tukey; * By default, alpha=0.05;
run;

proc glm data=clover;
	class strain;
	model nitrogen=strain;
	means strain/tukey alpha=0.1;
run;

/* Lack-of-fit */
data fiber;
	infile "&path\fiber.txt" firstobs=2;
	input fiber strength;
run;

proc print data=fiber;
run;

/* Full model */
proc glm data=fiber;
	class fiber;
	model strength=fiber;
run;
/* Reduced model */
proc glm data=fiber;
	model strength=fiber;
run;
