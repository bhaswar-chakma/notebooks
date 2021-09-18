use "F:\3-Advanced Econometrics I\Practice\Data\CentralBalancos-BP.dta", clear 

*1
describe

*2
summarize

*3
gen GROUPS="1-Micro" if MicE==1
replace GROUPS="2-Small" if SE==1
replace GROUPS="3-Medium" if MedE==1
replace GROUPS="4-Large" if LE==1
tabulate GROUPS

*4
tabulate GROUPS YEAR

*5
table GROUPS, contents(mean LEV_ST1 mean LEV_LT1 mean LEV1)

*6.1
keep if YEAR==1999
regress LEV_LT1 SIZE2 COLLAT2 PROF1 GROWTH2 AGE SE MedE LE

*7.1
gen PROF_SE=PROF1*SE
gen PROF_MedE=PROF1*MedE
gen PROF_LE=PROF1*LE 
regress LEV_LT1 SIZE2 COLLAT2 PROF1 GROWTH2 AGE PROF_SE PROF_MedE PROF_LE
test PROF_SE=PROF_MedE
test PROF_SE=PROF_LE
test PROF_MedE=PROF_LE

*7.2
gen SIZE_LE=SIZE2*LE
gen COLLAT_LE=COLLAT2*LE
gen GROWTH_LE=GROWTH2*LE
gen AGE_LE=AGE*LE
regress LEV_LT1 SIZE2 COLLAT2 PROF1 GROWTH2 AGE LE SIZE_LE COLLAT_LE PROF_LE GROWTH_LE AGE_LE
test LE SIZE_LE COLLAT_LE PROF_LE GROWTH_LE AGE_LE
regress LEV_LT1 SIZE2 COLLAT2 PROF1 GROWTH2 AGE if LE==0
regress LEV_LT1 SIZE2 COLLAT2 PROF1 GROWTH2 AGE if LE==1

*8.1
quietly regress LEV_LT1 SIZE2 COLLAT2 PROF1 GROWTH2 AGE SE MedE LE
estat ovtest

*8.2
estat hettest, rhs fstat

*8.1 (manual implementation)
predict XB
gen XB2=XB^2
gen XB3=XB^3
gen XB4=XB^4
quietly regress LEV_LT1 SIZE2 COLLAT2 PROF1 GROWTH2 AGE SE MedE LE XB2 XB3 XB4
test XB2 XB3 XB4

*8.2 (manual implementation)
quietly regress LEV_LT1 SIZE2 COLLAT2 PROF1 GROWTH2 AGE SE MedE LE
predict uhat, resid
gen uhat2=uhat^2
quietly regress uhat2 SIZE2 COLLAT2 PROF1 GROWTH2 AGE SE MedE LE
test SIZE2 COLLAT2 PROF1 GROWTH2 AGE SE MedE LE

*8.3
regress LEV_LT1 SIZE2 COLLAT2 PROF1 GROWTH2 AGE SE MedE LE, vce(robust)
regress LEV_LT1 SIZE2 COLLAT2 PROF1 GROWTH2 AGE SE MedE LE, vce(bootstrap,reps(500) seed(111))
