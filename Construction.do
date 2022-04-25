/*

Created by Hieu Nguyen
Data & Methods Section

Data Construction File
Created: 04-21-2021
Last updated: 04-24-2022

*/

clear
set more off
capture log close

*Set working directory to Command-Files folder

********************************************************************************

log using construction.log, replace
use ..\Original-Data\base	

* Some adjustments to the base data file
label variable countryID "Country ID based on ISO-3166 alpha-3"

save ..\Analysis-Data\analysis.dta, replace

**********************************************************************************

log close
exit


