use "F:\3-Advanced Econometrics I\Practice\Data\Verbeek2008-ch10-wages.dta", clear

xtset NR Year

*1
xtdescribe
describe

*2
summarize
xtsum Wage Schooling Exper Union South Public

*3
xttab Union
xttab South
xttab Public

*4.1
gen LWage=log(Wage)

regress LWage Schooling Exper Exper2 Union South Public, vce(cluster NR)
estimates store POOLED
xtreg LWage Schooling Exper Exper2 Union South Public, be
estimates store BE
xtreg LWage Schooling Exper Exper2 Union South Public, re vce(cluster NR)
estimates store RE
xtreg LWage Schooling Exper Exper2 Union  South Public, fe vce(cluster NR)
estimates store FE
areg LWage Schooling Exper Exper2 Union South Public, absorb(NR) vce(cluster NR)
estimates store LSDV

estimates table POOLED BE RE FE LSDV, b se
estimates table POOLED BE RE FE LSDV, b star(0.1 0.05 0.01)

*4.2
quietly xtreg LWage Schooling Exper Exper2 Union South Public, re
estimates store REs
quietly xtreg LWage Schooling Exper Exper2 Union South Public, fe
estimates store FEs
hausman FEs REs

*4.3
regress D.LWage D.Schooling D.Exper D.Exper2 D.Union D.South D.Public, vce(cluster NR) nocons

*4.4
xtreg LWage Schooling Exper Exper2 c.Union##i.Year South Public, re vce(cluster NR)

*5.1
xtivreg LWage Schooling Exper Exper2 (Union=L(1/4).Union) South Public, fe vce(cluster NR)

*5.2
xtivreg LWage Schooling Exper Exper2 (Union=L(1/2).Union F(1/2).Union) South Public, fe vce(cluster NR)
