use "G:\3-Advanced Econometrics I\Practice\Data\CentralBalancos-BP.dta", clear

drop if LE==1

*1
summarize LEV_LT1
count if LEV_LT==0
display 23027/30304

*2.1
glm LEV_LT1 SIZE2 COLLAT2 PROF1 GROWTH2 AGE, family(binomial) link(logit) vce(cluster id)
estimates store LOGIT

*2.2
gen DEBT=LEV_LT1>0
probit DEBT SIZE2 COLLAT2 PROF1 GROWTH2 AGE, vce(cluster id)
estimates store TP1
glm LEV_LT1 SIZE2 COLLAT2 PROF1 GROWTH2 AGE if LEV_LT>0, family(binomial) link(logit) vce(cluster id)
estimates store TP2

*2.3
tobit LEV_LT1 SIZE2 COLLAT2 PROF1 GROWTH2 AGE, ll(0) vce(cluster id)
estimates store TOBIT

*3.1
estimates restore LOGIT
scalar xb = _b[_cons] + _b[SIZE2]*13.54 + _b[COLLAT2]*0.41 + _b[PROF1]*0.07 + _b[GROWTH2]*15.03 + _b[AGE]*19
display exp(xb)/(1+exp(xb))

estimates restore TP1
scalar xb1 = _b[_cons] + _b[SIZE2]*13.54 + _b[COLLAT2]*0.41 + _b[PROF1]*0.07 + _b[GROWTH2]*15.03 + _b[AGE]*19
estimates restore TP2
scalar xb2 = _b[_cons] + _b[SIZE2]*13.54 + _b[COLLAT2]*0.41 + _b[PROF1]*0.07 + _b[GROWTH2]*15.03 + _b[AGE]*19
display normal(xb1)*exp(xb2)/(1+exp(xb2))

estimates restore TOBIT
scalar xbt = _b[_cons] + _b[SIZE2]*13.54 + _b[COLLAT2]*0.41 + _b[PROF1]*0.07 + _b[GROWTH2]*15.03 + _b[AGE]*19
display normal(xbt/sqrt(_b[/var(e.LEV_LT1)]))*xbt+sqrt(_b[/var(e.LEV_LT1)])*normalden(xbt/sqrt(_b[/var(e.LEV_LT1)]))

*3.2
display normal(xb1)
estimates restore TOBIT
display normal(xbt/sqrt(_b[/var(e.LEV_LT1)]))

*3.3
display exp(xb2)/(1+exp(xb2))
estimates restore TOBIT
display xbt+sqrt(_b[/var(e.LEV_LT1)])*normalden(xbt/sqrt(_b[/var(e.LEV_LT1)]))/normal(xbt/sqrt(_b[/var(e.LEV_LT1)]))

*4
xtset id YEAR
gen LEVt= LEV_LT1/(1- LEV_LT1)
xtpoisson LEVt SIZE2 COLLAT2 PROF1 GROWTH2 AGE, fe vce(robust)
