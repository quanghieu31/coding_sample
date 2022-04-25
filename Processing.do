/*

Created by Hieu Nguyen
Combining data - Final Processing Section

Data Processing File
Date created: 03-25-2021
Last updated: 04-24-2022


*/

clear
set more off
capture log close

//Set working directory to Command_Files subfolder

********************************************************************************

log using processing.log, replace

use ..\Original-Data\all_dep.dta	// this serves as the "master" data

*We now move on to merge two data base files:
merge 1:m country year using ..\Original-Data\all_expl

drop _merge  // we don't need this variable anymore

save ..\Original-Data\base.dta, replace // save the final, clean data base file

********************************************************************************

log close
exit