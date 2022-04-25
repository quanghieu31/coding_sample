/*

Created by Hieu Nguyen
Results & Discussion Section

Data Analysis File
Created: 05-02-2021
Last updated: 04-24-2022

*/

clear
set more off
capture log close

*Set working directory to Command-Files folder

********************************************************************************

log using analysis.log, replace
use ..\Analysis-Data\analysis.dta
ssc install outreg2

xtset countryID year	// let Stata know we are working with panel data bt defining the entity variable (countryID) and time variable (year)


********************************************************************************

* Some graphs representing trends of the dependent variables
xtline GDP, t(year) i(countryID) overlay
graph export "..\Analysis-Data\gdp.png", as(png) name("Graph") replace

xtline female_inc, t(year) i(countryID) overlay
graph export "..\Analysis-Data\income.png", as(png) name("Graph") replace

xtline HDI_female, t(year) i(countryID) overlay
graph export "..\Analysis-Data\hdi.png", as(png) name("Graph") replace


/*  Table 1: First model specification with GDP as the dependent variable  */

reg GDP FDI capital export_import unemployment i.year, robust // pooled OLS
outreg2 using ..\Analysis-Data\regresults_1.xls, ctitle(Pooled OLS) replace // col (1)

xtreg GDP FDI capital export_import unemployment i.year, fe vce(cluster countryID) 	// fixed effects with year fixed effects (two way)
outreg2 using ..\Analysis-Data\regresults_1.xls, ctitle(Fixed Effects 1) append // col (2)
testparm i.year 		// see if year is statistically significant => not

xtreg GDP FDI capital export_import unemployment, fe vce(cluster countryID)	// fixed effects with no year fixed effects
outreg2 using ..\Analysis-Data\regresults_1.xls, ctitle(Fixed Effects 2) append // col (3)


********************************************************************************

/*  Second model specifications with female_inc and HDI_female as the dependent variables  */

** Table 2: Income as the dependent variable

reg female_inc FDI capital export_import unemployment i.year, robust // pooled OLS
outreg2 using ..\Analysis-Data\regresults_2.xls, ctitle(Pooled OLS) replace // col (1)

xtreg female_inc FDI capital export_import unemployment i.year, fe vce(cluster countryID) 	// fixed effects with year fixed effects (two way)
outreg2 using ..\Analysis-Data\regresults_2.xls, ctitle(Fixed Effects) append // col (2)
testparm i.year		// year fixed effects is statistically significant

xtreg female_inc FDI capital export_import unemployment i.year, vce(cluster countryID)	// random effects
outreg2 using ..\Analysis-Data\regresults_2.xls, ctitle(Random Effects) append // col (3)

** Table 3: HDI as the dependent variable

reg HDI_female FDI capital export_import unemployment i.year, robust // pooled OLS
outreg2 using ..\Analysis-Data\regresults_3.xls, ctitle(Pooled OLS) replace // col (1)

xtreg HDI_female FDI capital export_import unemployment i.year, fe vce(cluster countryID) 	// fixed effects with year fixed effects (two way)
outreg2 using ..\Analysis-Data\regresults_3.xls, ctitle(Fixed Effects) append // col (2)
testparm i.year		// year fixed effects is statistically significant

xtreg HDI_female FDI capital export_import unemployment i.year, vce(cluster countryID)	// random effects
outreg2 using ..\Analysis-Data\regresults_3.xls, ctitle(Random Effects) append // col (3)


********************************************************************************

log close
exit