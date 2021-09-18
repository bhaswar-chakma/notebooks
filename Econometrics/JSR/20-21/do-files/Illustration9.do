use "F:\3-Advanced Econometrics I\Practice\Data\CameronTrivedi2010-ch18-health.dta", clear

*1
summarize med
summarize med if med>0

*2.1
drop if year!=1
poisson med lcoins ndisease female age lfam child, robust
estimates store poisson

*2.2
poisson med lcoins ndisease female age lfam child if med>0, robust
estimates store poisson0

*2.3
gen lmed=log(med)
regress lmed lcoins ndisease female age lfam child if med>0, robust
estimates store log0

*2.4
gen lmed1=log(med+1)
regress lmed1 lcoins ndisease female age lfam child, robust
estimates store log1

estimates table poisson poisson0, b star(0.1 0.05 0.01)
estimates table log0 log1, b star(0.1 0.05 0.01)

*3.1
summarize mdu
tabulate mdu

*3.2.1
poisson mdu lcoins ndisease female age lfam child
estimates store cpoissonml

*3.2.2
poisson mdu lcoins ndisease female age lfam child, robust
estimates store cpoissonqml

*3.2.3
nbreg mdu lcoins ndisease female age lfam child, dispersion(constant)
estimates store cnegbin1

*3.2.4
nbreg mdu lcoins ndisease female age lfam child, dispersion(mean)
estimates store cnegbin2

estimates table cpoissonml cpoissonqml cnegbin1 cnegbin2, b star(0.1 0.05 0.01)

*3.3
estimates restore cpoissonml

scalar lambda0 = exp(_b[_cons] + _b[lcoins]*log(1) + _b[age]*50 + _b[lfam]*log(3))
scalar lambda1 = exp(_b[_cons] + _b[lcoins]*log(51) + _b[age]*50 + _b[lfam]*log(3))
scalar lambda2 = exp(_b[_cons] + _b[lcoins]*log(101) + _b[age]*50 + _b[lfam]*log(3))

display lambda0
display lambda1
display lambda2

display exp(-lambda0)
display exp(-lambda1)
display exp(-lambda2)

display exp(-lambda0)*lambda0
display exp(-lambda1)*lambda1
display exp(-lambda2)*lambda2

display 1-0.10890092-0.24146784
display 1-0.18352361-0.31114812
display 1-0.19826418-0.32082215

*4.1
use "F:\3-Advanced Econometrics I\Practice\Data\CameronTrivedi2010-ch18-health.dta", clear
xtset id year
xtdescribe

*4.2.1
poisson mdu lcoins ndisease female age lfam child, vce(cluster id)
estimates store pooled

*4.2.2
xtpoisson mdu lcoins ndisease female age lfam child, re
estimates store RE

*4.2.3
xtpoisson mdu lcoins ndisease female age lfam child, fe
estimates store FE

estimates table pooled RE FE, b star(0.1 0.05 0.01)

*4.2.4
hausman FE RE
