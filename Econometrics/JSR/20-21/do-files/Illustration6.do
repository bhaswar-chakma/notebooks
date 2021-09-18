use "F:\3-Advanced Econometrics I\Practice\Data\CameronTrivedi2010-ch18-health.dta", clear

xtset id year

*1.1
xtdescribe
describe

*1.2
xtsum lcoins ndisease female age lfam child

*1.3
xttab dmdu

*2
logit dmdu lcoins ndisease female age lfam child, vce(cluster id)
estimates store POOLED
xtlogit dmdu lcoins ndisease female age lfam child
estimates store RE
xtlogit dmdu lcoins ndisease female age lfam child, fe
estimates store FE

estimates table POOLED RE FE, b star(0.1 0.05 0.01)
