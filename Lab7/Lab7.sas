dm 'log; clear; output; clear'; *Clear windows;
%let path = \\stat.ad.ncsu.edu\Redirect\zliu15\Desktop\ST Courses\ST512 Lab (TA); * macro variable to represent the input path;

/* Read in example */
data info;
	input name $ height;
	datalines;
	John 72
	Bob 20
	Kevin 100
	;
run;

proc print data=info;
run;

ods html close; *close previous results window;
ods html; *open new;

proc means data=info;
	var height;
run;

/* Bodyfat */
data bodyfat;
	infile "&path\bodyfat.txt" firstobs=2;
	input bodyfat age weight height neck chest abdomen hip thigh knee ankle biceps forearm wrist;
run;

proc contents data=bodyfat;
run;

/* Regression */
proc glm data=bodyfat;
	model bodyfat=age weight height;
run;

/* Model selection */
proc glmselect data=bodyfat;
	model bodyfat=age weight height neck chest abdomen hip thigh knee ankle biceps forearm wrist / selection=stepwise(select=aic);
run;

proc glmselect data=bodyfat;
	model bodyfat=age weight height neck chest abdomen hip thigh knee ankle biceps forearm wrist / selection=stepwise(select=press);
run;

proc glmselect data=bodyfat;
	model bodyfat=age weight height neck chest abdomen hip thigh knee ankle biceps forearm wrist / selection=stepwise(select=sl slentry=0.05 slstay=0.1);
run;

proc glmselect data=bodyfat;
	model bodyfat=age weight height neck chest abdomen hip thigh knee ankle biceps forearm wrist / selection=forward(select=press);
run;
