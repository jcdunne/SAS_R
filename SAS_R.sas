/*Creating Data Library*/
libname progeny "C:\Users\jcdunne\NC State PB&G Dropbox\Jeffrey Dunne\Guest Lecture";

/*Importing Data to Progeny Library*/
proc import datafile="C:\Users\jcdunne\NC State PB&G Dropbox\Jeffrey Dunne\Guest Lecture\SAS - R Guest Lecture Data.xlsx" out=progeny.yield dbms=xlsx replace;
sheet="Yield";
run;

/*Check the Contents of the Progeny.Yield Data File*/
proc contents data=progeny.yield;
run;

/*Print the First 5 Lines of the Progeny Yield*/
proc print data=progeny.yield (obs=5);
run;

/*Checking Data - Balanced vs Unbalanced*/
proc freq data=progeny.yield;
table Location Rep NC_Accession;
run;

/*Modeling the Population Progeny Screen (50 Lines)*/
ods rtf file='GLM Progeny Yield.rtf';
title "GLM Analysis of Peanut Progeny Screen";
proc glm data=progeny.yield;
class location rep nc_accession;
model yield = location rep(location) nc_accession location*nc_accession;
random location rep(location) nc_accession location*nc_accession / test;
lsmeans nc_accession;
run;
quit;
ods rtf close;

ods rtf file='MIXED Progeny Yield.rtf';
title "MIXED Analysis of Peanut Progeny Screen";
proc mixed data=progeny.yield covtest;
class location rep nc_accession;
model yield = nc_accession / solution;
random location rep(location) nc_accession location*nc_accession / solution;
ods output solutionR = progeny.random solutionF = progeny.fixed;
run;
ods rtf close;
