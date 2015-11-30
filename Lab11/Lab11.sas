dm 'log; clear; output; clear'; *Clear windows;
%let path = \\stat.ad.ncsu.edu\Redirect\zliu15\Desktop\ST Courses\ST512 Lab (TA); * macro variable to represent the input path;

/* Read in data */
data loaf;
	infile "&path\loaf.txt" firstobs=2;
	input fat $ surfactant $ supplier $ volume;
run;

proc print data=loaf;
run;

/* Means for each trt combination */
proc means data=loaf;
	var volume;
	by fat surfactant;
	output out=lmean mean=vmean;
run;
/* Interaction plot */
symbol1 color=blue interpol=join line=1 value=triangle;
symbol2 color=green interpol=join line=2 value=square;
symbol3 color=red interpol=join line=20 value=circle;

proc gplot data=lmean;
	plot vmean*fat=surfactant;
run;

/* ANOVA */
proc glm data=loaf;
	class fat surfactant supplier;
	model volume=fat|surfactant supplier;
	lsmeans fat*surfactant / slice=fat;
run;

/* Latin Squares */
data melon;
	infile "&path\melon.txt" firstobs=2;
	input rblock $ cblock $ method $ rate $ y;
run;

proc glm data=melon;
	class rblock cblock method rate;
	model y=method|rate rblock cblock;
run;
