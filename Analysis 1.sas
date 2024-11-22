libname AIDSVU "C:\Users\redua\Desktop\AIDSVU";


 ** The Age group dataset will be tested for normality and homogeneity of variance assumptions**
              ** CHECKING FOR NORMALITY using qqplot**; 
                For AGEGROUP;
                
   DATA AGEGROUPS;   **creating AGEGROUPS in work library**;
SET AIDSVU.PREPAGE;
RUN;             
                
                
 
PROC UNIVARIATE DATA=AGEGROUPS;
VAR PNR;
QQPLOT PNR;
RUN;

 
 
            ** Checking for equal variance**;
                for AGEGROUP USING ANOVA/;
 
 PROC glm DATA= AGEGROUPS;
 CLASS AGE_GROUP;
 MODEL PNR= AGE_GROUP;
 MEANS AGE_GROUP/ HOVTEST=bf;
 RUN;
 
 ** PERFORM TUKEY’S Honestly Significant Difference (HSD) test**
       FOR AGEGROUPS;

    proc glm data = AGEGROUPS ;
	class AGE_GROUP;
	model PNR=AGE_GROUP;
	means AGE_GROUP/ tukey cldiff;
run;
 
 
 
  ** USING DESCRIPTIVE STATISTICS FOR PREPSTATE**;
  
  DATA PREPSTATES;
SET aidsvu.prepstate; ** creating prepstates in work libary**
RUN;
  
proc MEANS data=prepstates;
var PNR;
RUN;

proc univariate data =prepstates ; 
	var PNR; 
	histogram PNR;
	probplot PNR; 
run;
 
 ** Testing for normality and variance assumptions for INDEPENDENT T- TEST using proc glm";
 
 DATA GENDER1;         ** Creating gender1 dataset in the work library**;
SET AIDSVU.PREPGENDER;
RUN;

** Analysis of normality and variance assumptions and finding t-statistics**; 
 proc TTEST data=GENDER1;
	class GENDER;
	VAR PNR;
run;
       
       
        
       
       
       
       
 