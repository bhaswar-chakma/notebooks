use "F:\3-Advanced Econometrics I\Practice\Data\FransesPaap2001-ch4-brands.dta", clear

*1
describe

*2
summarize Heinz Hunts Dhei Dhun Fhei Fhun DFhei DFhun Phei Phun

*3
gen lpp=ln(Phei/Phun)

logit Heinz Dhei Dhun Fhei Fhun DFhei DFhun lpp
estimates store logit
probit Heinz Dhei Dhun Fhei Fhun DFhei DFhun lpp
estimates store probit
cloglog Heinz Dhei Dhun Fhei Fhun DFhei DFhun lpp
estimates store cloglog

estimates table logit probit cloglog, b star(0.1 0.05 0.01)

*4
estimates restore logit
predict XBl, xb
gen XBl2=XBl^2
quietly logit Heinz Dhei Dhun Fhei Fhun DFhei DFhun lpp XBl2
test XBl2

estimates restore probit
predict XBp, xb
gen XBp2=XBp^2
quietly probit Heinz Dhei Dhun Fhei Fhun DFhei DFhun lpp XBp2
test XBp2

estimates restore cloglog
predict XBcl, xb
gen XBcl2=XBcl^2
quietly cloglog Heinz Dhei Dhun Fhei Fhun DFhei DFhun lpp XBcl2
test XBcl2

*5.1
quietly probit Heinz Dhei Dhun Fhei Fhun DFhei DFhun lpp XBp2
estimates store probitR
lrtest probit probitR

*5.2
estimates restore probit
estat classification

*6.1
summarize Phei Phun
scalar lppm=log(0.0348276/0.0335547)
display normal(_b[_cons]+_b[lpp]*lppm)
display normal(_b[_cons]+_b[DFhei]+_b[lpp]*lppm)
display normal(_b[_cons]+_b[DFhun]+_b[lpp]*lppm)
display normal(_b[_cons]+_b[DFhei]+_b[DFhun]+_b[lpp]*lppm)

*6.2
margins, dydx(_all)

*6.3
margins, dydx(DFhun) at(Dhei=0 Fhei=0 DFhei=0 Dhun=0 Fhun=0 DFhun=0 lpp=0)

*6.4
gen P1=normal(_b[_cons]+_b[lpp]*lpp)
gen P2=normal(_b[_cons]+_b[DFhei]+_b[lpp]*lpp)
gen P3=normal(_b[_cons]+_b[DFhun]+_b[lpp]*lpp)
line P1 P2 P3 lpp if lpp > -0.6 & lpp < 0.6, lpattern(solid dash dot)

