dm 'log; clear; output; clear'; *Clear windows;
%let path = \\stat.ad.ncsu.edu\Redirect\zliu15\Desktop\ST Courses\ST512 Lab (TA); * macro variable to represent the input path;

/* Read in data */
data wood;
	infile "&path\wood.txt" firstobs=2;
	input type $ stove $ moisture energy;
run;

proc print data=wood;
run;

/* Contingency table */
proc freq data=wood;
	tables type*stove/nocol norow nopercent;
run;

/* Plot */
symbol1 color=blue value=triangle;
symbol2 color=green value=square;
symbol3 color=red value=circle;
symbol4 color=black value=diamond;

proc gplot data=wood;
	plot energy*moisture=type;
run;

/* ANCOVA */
proc glm data=wood;
	class stove type;
	model energy=stove moisture|type;
run;

/* Refit */
proc glm data=wood;
	class stove type;
	model energy=stove moisture type;
	lsmeans type/pdiff adjust=tukey;
run;
