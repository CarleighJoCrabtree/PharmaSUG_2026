/*******************************************/
/* Timing, Masking, and Resolution:        */
/* Understanding and Debugging SAS Macros  */
/* PharmaSUG 2026 AP-228                   */
/* Carleigh Jo Crabtree                    */
/*******************************************/

/**************************************/
/* Access data and turn on SYMBOLGEN: */
/**************************************/

options validvarname=v7;
/* Modify the path to your file location. */
libname pharm xlsx "C:/PharmaSUG/TimingMaskingResolution/Sports_Supplements.xlsx";

/* Displays results of resolved macro variables in the log. */
options symbolgen;

/**************************************/
/* Example 1: Expected Macro Behavior */
/**************************************/

/* Works as expected. */
%let claim=endurance;

title "Supplements Claimed to Improve: &claim";
proc print data=pharm.sports_supplements;
	where  Claimed_Improved_Fitness_Aspect="&claim";
run;

/****************************************************************/
/* Example 2: Warning- Apparent Symbolic Reference Not Resolved */
/****************************************************************/

/* Works, but produces warnings in the log because of &muscle. */
%let claim=inflammation&muscle soreness;

title "Supplements Claimed to Improve: &claim";
proc print data=pharm.sports_supplements;
	where  Claimed_Improved_Fitness_Aspect="&claim";
run;

/**********************************/
/* Example 3: Unwanted Resolution */
/**********************************/

/* Works but no report is generated. */ 
/* The value of &muscle is resolved within the value of &claim. */
%let muscle=UnwantedText;
%let claim=inflammation&muscle soreness;

title "Supplements Claimed to Improve: &claim";
proc print data=pharm.sports_supplements;
	where  Claimed_Improved_Fitness_Aspect="&claim";
run;

/*********************/
/* Example 4: %NRSTR */
/*********************/

/* %NRSTR masks the & so it is treated as text rather than a macro trigger. */
%let muscle=UnwantedText;
%let claim=%nrstr(inflammation&muscle soreness);

title "Supplements Claimed to Improve: &claim";
proc print data=pharm.sports_supplements;
	where  Claimed_Improved_Fitness_Aspect="&claim";
run;

/*******************************************/
/* Example 5: %STR and Pairwise Characters */
/*******************************************/

/* Quotations are pairwise characters. */
/* SAS will continue looking for the closing quotation mark resulting in problems. */
/* If the following is run, reset the SAS session. */
/* %let altName= %str(devil's thorn, tackweed); */

/* %STR with the % in front of the quotation mark masks the single quotation mark. */
%let altName= %str(devil%'s thorn, tackweed);
%put &=altName;

/*******************************************/
/* Visualizing Macro Timing and Resolution */
/*******************************************/

/* When %UPCASE is used, the returned result of &claim is unmasked and undesired results are produced. */
%let muscle=UnwantedText;
%let claim=%nrstr(inflammation&muscle soreness);
%let uClaim=%upcase(&claim);

%put &=uClaim;

/* Log: */
/* UCLAIM=INFLAMMATIONUnwantedText SORENESS */

/********************************/
/* Example 6: Macro Q Functions */
/********************************/

/* Macro Q functions mask returned results. */
/* When %QUPCASE is used, the returned result of &claim is masked so the word scanner does not interpret the ampersand as a macro trigger. */
%let muscle=UnwantedText;
%let claim=%nrstr(inflammation&muscle soreness);
%let QuClaim=%qupcase(&claim);

%put &=QuClaim;

/* Log: */
/* QUCLAIM=INFLAMMATION&MUSCLE SORENESS */






